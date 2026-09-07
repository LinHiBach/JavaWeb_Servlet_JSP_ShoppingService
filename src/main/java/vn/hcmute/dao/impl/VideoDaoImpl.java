package vn.hcmute.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.hcmute.config.JpaConfig;
import vn.hcmute.dao.IVideoDao;
import vn.hcmute.entity.Video;

public class VideoDaoImpl implements IVideoDao {

    @Override
    public void insert(Video video) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Video video) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Video video = enma.find(Video.class, id);
            if (video != null) {
                enma.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Video findById(String id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Video.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Video> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Video> query = enma.createNamedQuery("Video.findAll", Video.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Video> findByTitle(String title) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.title LIKE :title";
            TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
            query.setParameter("title", "%" + title + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Video> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            TypedQuery<Video> query = enma.createNamedQuery("Video.findAll", Video.class);
            int first = page > 0 ? (page - 1) * pagesize : 0;
            query.setFirstResult(first);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(v) FROM Video v";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            return query.getSingleResult().intValue();
        } finally {
            enma.close();
        }
    }
}
