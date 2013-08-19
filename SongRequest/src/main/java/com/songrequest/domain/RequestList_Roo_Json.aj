// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.songrequest.domain;

import com.songrequest.domain.RequestList;
import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

privileged aspect RequestList_Roo_Json {
    
    public String RequestList.toJson() {
        return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    public static RequestList RequestList.fromJsonToRequestList(String json) {
        return new JSONDeserializer<RequestList>().use(null, RequestList.class).deserialize(json);
    }
    
    public static String RequestList.toJsonArray(Collection<RequestList> collection) {
        return new JSONSerializer().exclude("*.class").serialize(collection);
    }
    
    public static Collection<RequestList> RequestList.fromJsonArrayToRequestLists(String json) {
        return new JSONDeserializer<List<RequestList>>().use(null, ArrayList.class).use("values", RequestList.class).deserialize(json);
    }
    
}
