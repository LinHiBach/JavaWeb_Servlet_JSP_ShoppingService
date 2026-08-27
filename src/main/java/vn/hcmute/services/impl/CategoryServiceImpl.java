package vn.hcmute.services.impl;

import java.io.File;
import java.util.List;
import vn.hcmute.dao.ICategoryDao;
import vn.hcmute.dao.impl.CategoryDaoImpl;
import vn.hcmute.entity.Category;
import vn.hcmute.services.ICategoryService;
import vn.hcmute.utils.Constant;

public class CategoryServiceImpl implements ICategoryService {
    private final ICategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category newCategory) {
        Category oldCategory = categoryDao.findById(newCategory.getCategoryId());
        if (oldCategory != null) {
            oldCategory.setCategoryname(newCategory.getCategoryname());
            oldCategory.setStatus(newCategory.getStatus());
            if (newCategory.getImages() != null && !newCategory.getImages().isEmpty()) {
                // Xóa ảnh cũ nếu người dùng cập nhật ảnh mới
                String oldFileName = oldCategory.getImages();
                if (oldFileName != null && !oldFileName.isEmpty()) {
                    File file = new File(Constant.DIR + File.separator + oldFileName);
                    if (file.exists()) {
                        file.delete();
                    }
                }
                oldCategory.setImages(newCategory.getImages());
            }
            categoryDao.update(oldCategory);
        } else {
            categoryDao.update(newCategory);
        }
    }

    @Override
    public void edit(Category category) {
        update(category);
    }

    @Override
    public void delete(int id) {
        Category oldCategory = categoryDao.findById(id);
        if (oldCategory != null && oldCategory.getImages() != null) {
            File file = new File(Constant.DIR + File.separator + oldCategory.getImages());
            if (file.exists()) {
                file.delete();
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public Category findByCategoryname(String name) {
        return categoryDao.findByCategoryname(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.searchByName(keyword);
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword);
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        return categoryDao.findAll(page, pagesize);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }
}