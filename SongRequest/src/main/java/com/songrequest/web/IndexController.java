package com.songrequest.web;

import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.songrequest.domain.RequestList;
import com.songrequest.domain.SongRequest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
	
@Controller
public class IndexController {

	final static private HttpHeaders jsonHeaders = new HttpHeaders();
	static{
        jsonHeaders.add("Content-Type", "application/json; charset=utf-8");
	}

	@RequestMapping(value = { "/" })
    public String index(){
        return "create";
    }

    @RequestMapping(value = { "/{token}" })
    public String list(@PathVariable("token") final String token){
    	List<RequestList> requestLists = RequestList.findRequestListsByToken(token).getResultList();
    	if(requestLists.size() != 1){
    		return "create";
    	}
    	
        return "list";
    }
    
    @RequestMapping(value = { "/spotify/search/track"})
    public ResponseEntity<String> searchTrack(@RequestParam(value = "q", required = true) final String query) {

    	try {
    		return new ResponseEntity<String>(sendTrackQuery(query), jsonHeaders, HttpStatus.OK);
			
		} catch (IOException e) {
			return new ResponseEntity<String>(jsonHeaders, HttpStatus.NOT_FOUND);
		}
	}
    
    @RequestMapping(value = { "/spotify/lookup/uri"})
    public ResponseEntity<String> uriLookup(@RequestParam(value = "uri", required = true) final String uri) {

    	try {
    		return new ResponseEntity<String>(sendUriQuery(uri), jsonHeaders, HttpStatus.OK);
			
		} catch (IOException e) {
			return new ResponseEntity<String>(jsonHeaders, HttpStatus.NOT_FOUND);
		}
	}
    
    private String sendTrackQuery(String query) throws IOException{
	    URL url;
     	HttpURLConnection conn;
     	BufferedReader rd;
     	String line;
     	String result = "";
 		url = new URL("http://ws.spotify.com/search/1/track.json?q=" + query);
 		conn = (HttpURLConnection) url.openConnection();
 		conn.setRequestMethod("GET");
 		rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
 		while ((line = rd.readLine()) != null) {
 			result += line;
 		}
 		rd.close();
     	return result; 
    } 
    
    private String sendUriQuery(String uri) throws IOException {
    	URL url;
     	HttpURLConnection conn;
     	BufferedReader rd;
     	String line;
     	String result = "";
 		url = new URL("http://ws.spotify.com/lookup/1/.json?uri=spotify:track:" + uri);
 		conn = (HttpURLConnection) url.openConnection();
 		conn.setRequestMethod("GET");
 		rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
 		while ((line = rd.readLine()) != null) {
 			result += line;
 		}
 		rd.close();
     	
     	return result;
    }
}