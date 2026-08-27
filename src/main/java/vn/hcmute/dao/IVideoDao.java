package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.Video;

public interface IVideoDao {
    void insert(Video video);
    void update(Video video);
    void delete(String id);
    Video findById(String id);
    List<Video> findAll();
    List<Video> findByTitle(String title);
    List<Video> findAll(int page, int pagesize);
    int count();
}
