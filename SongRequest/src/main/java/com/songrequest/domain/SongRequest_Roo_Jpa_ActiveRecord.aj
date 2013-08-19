// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.songrequest.domain;

import com.songrequest.domain.SongRequest;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect SongRequest_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager SongRequest.entityManager;
    
    public static final EntityManager SongRequest.entityManager() {
        EntityManager em = new SongRequest().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long SongRequest.countSongRequests() {
        return entityManager().createQuery("SELECT COUNT(o) FROM SongRequest o", Long.class).getSingleResult();
    }
    
    public static List<SongRequest> SongRequest.findAllSongRequests() {
        return entityManager().createQuery("SELECT o FROM SongRequest o", SongRequest.class).getResultList();
    }
    
    public static SongRequest SongRequest.findSongRequest(Long id) {
        if (id == null) return null;
        return entityManager().find(SongRequest.class, id);
    }
    
    public static List<SongRequest> SongRequest.findSongRequestEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM SongRequest o", SongRequest.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void SongRequest.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void SongRequest.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            SongRequest attached = SongRequest.findSongRequest(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void SongRequest.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void SongRequest.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public SongRequest SongRequest.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        SongRequest merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
