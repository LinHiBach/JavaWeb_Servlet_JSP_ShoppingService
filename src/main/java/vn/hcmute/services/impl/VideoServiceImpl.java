package vn.hcmute.services.impl;

import java.util.List;
import vn.hcmute.dao.IVideoDao;
import vn.hcmute.dao.impl.VideoDaoImpl;
import vn.hcmute.entity.Video;
import vn.hcmute.services.IVideoService;

public class VideoServiceImpl implements IVideoService {
    private final IVideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video video) {
        videoDao.update(video);
    }

    @Override
    public void delete(String id) {
        videoDao.delete(id);
    }

    @Override
    public Video findById(String id) {
        return videoDao.findById(id);
    }

    @Override
    public List<Video> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video> findByTitle(String title) {
        return videoDao.findByTitle(title);
    }

    @Override
    public List<Video> findAll(int page, int pagesize) {
        return videoDao.findAll(page, pagesize);
    }

    @Override
    public int count() {
        return videoDao.count();
    }
}
