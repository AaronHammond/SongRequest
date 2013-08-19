package com.songrequest.web;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.songrequest.JsonWrapper;
import com.songrequest.domain.RequestList;
import com.songrequest.domain.SongRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/requestlists")
@Controller
public class RequestListController {
	
	final static private HttpHeaders jsonHeaders = new HttpHeaders();
	static{
        jsonHeaders.add("Content-Type", "application/json; charset=utf-8");
	}
	
	@RequestMapping(value = "/{token}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> showJson(@PathVariable("token") final String token) {
		final List<RequestList> requestLists = RequestList.findRequestListsByToken(token).getResultList();
		
        if(requestLists.size() != 1) {
            return new ResponseEntity<String>(jsonHeaders, HttpStatus.NOT_FOUND);
        }
        Set<SongRequest> songRequests = requestLists.get(0).getSongRequests();
        return new ResponseEntity<String>(new JsonWrapper(songRequests, true, (long)songRequests.size(), "OK", (long)songRequests.size()).toJson(), jsonHeaders, HttpStatus.OK);
    }
	
	@RequestMapping(value = "/create", method = RequestMethod.POST)
    public ResponseEntity<String> createFromJson() {
        
		RequestList requestList = new RequestList();
		requestList.setToken(this.getAlphaNumeric(9));
		requestList.setCreatedDate(new Date());
		requestList.persist();
        

        return new ResponseEntity<String>(requestList.toJson(), jsonHeaders, HttpStatus.CREATED);
    }
	
	
	private static final String ALPHA_NUM = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private String getAlphaNumeric(int len) {
		StringBuffer sb = new StringBuffer(len);
		for (int i = 0; i < len; i++) {
		int ndx = (int) (Math.random() * ALPHA_NUM.length());
		sb.append(ALPHA_NUM.charAt(ndx));
		}
		return sb.toString().toLowerCase();
	}

	
}
