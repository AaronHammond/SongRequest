// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.songrequest.domain;

import com.songrequest.domain.RequestList;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect RequestList_Roo_Jpa_Entity {
    
    declare @type: RequestList: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long RequestList.id;
    
    @Version
    @Column(name = "version")
    private Integer RequestList.version;
    
    public Long RequestList.getId() {
        return this.id;
    }
    
    public void RequestList.setId(Long id) {
        this.id = id;
    }
    
    public Integer RequestList.getVersion() {
        return this.version;
    }
    
    public void RequestList.setVersion(Integer version) {
        this.version = version;
    }
    
}