package com.songrequest;



import flexjson.JSONSerializer;
import flexjson.transformer.DateTransformer;

import java.util.Date;

public class JsonWrapper {
    private Object data;
    private boolean success;
    private long count;
    private String message;
    private long total;

    public long getTotal() {
        return total;
    }

    public Object getData() {
        return data;
    }

    public boolean isSuccess() {
        return success;
    }

    public long getCount() {
        return count;
    }

    public String getMessage() {
        return message;
    }

    public JsonWrapper(final Object data, final boolean success, final long count, final String message, final long total) {
        this.data = data;
        this.success = success;
        this.count = count;
        this.message = message;
        this.total = total;
    }

    public String toJson() {
        return new JSONSerializer().exclude("*.class")
        		.transform(new DateTransformer("MM/dd/yyyy"), Date.class)
        		.serialize(this);
    }
}

