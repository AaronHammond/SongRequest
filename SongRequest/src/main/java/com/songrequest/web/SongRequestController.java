package com.songrequest.web;

import java.util.List;

import com.songrequest.domain.RequestList;
import com.songrequest.domain.SongRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/songrequests")
@Controller
public class SongRequestController {
	
	final static private HttpHeaders jsonHeaders = new HttpHeaders();
	static{
        jsonHeaders.add("Content-Type", "application/json; charset=utf-8");
	}
	
	@RequestMapping(method = RequestMethod.POST, headers = "Accept=application/json")
    public ResponseEntity<String> createFromJson(@RequestBody final String json,
    												@RequestParam(value = "token", required = true) final String token) {

		final SongRequest songRequest = SongRequest.fromJsonToSongRequest(json);
        songRequest.persist();
        
        final List<RequestList> requestLists = RequestList.findRequestListsByToken(token).getResultList();
		
        if(requestLists.size() != 1) {
            return new ResponseEntity<String>(jsonHeaders, HttpStatus.NOT_FOUND);
        }

        RequestList requestList = requestLists.get(0);
        requestList.getSongRequests().add(songRequest);
        requestList.persist();
        
        return new ResponseEntity<String>(jsonHeaders, HttpStatus.CREATED);
    }
}
