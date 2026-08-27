package vn.hcmute.models;

import vn.hcmute.entity.Category;

public class CategoryModel extends Category {
    private static final long serialVersionUID = 1L;

    public CategoryModel() {
        super();
    }

    public CategoryModel(int id, String name, String icon) {
        super(name, icon);
        this.setId(id);
    }

    public CategoryModel(String name, String icon) {
        super(name, icon);
    }

    public CategoryModel(int id, String name, String icon, int status) {
        super(id, name, icon, status);
    }

    public CategoryModel(Category cate) {
        if (cate != null) {
            this.setId(cate.getCategoryId());
            this.setName(cate.getCategoryname());
            this.setIcon(cate.getImages());
            this.setStatus(cate.getStatus());
            this.setVideos(cate.getVideos());
        }
    }
}