package vn.hcmute.services.impl;

import java.io.File;
import java.util.List;
import vn.hcmute.dao.ICategoryDao;
import vn.hcmute.dao.impl.CategoryDaoImpl;
import vn.hcmute.models.CategoryModel;
import vn.hcmute.services.ICategoryService;
import vn.hcmute.utils.Constant;

public class CategoryServiceImpl implements ICategoryService {
    private final ICategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(CategoryModel category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(CategoryModel newCategory) {
        CategoryModel oldCategory = categoryDao.get(newCategory.getId());
        oldCategory.setName(newCategory.getName());
        if (newCategory.getIcon() != null) {
            // Xóa ảnh cũ nếu người dùng cập nhật ảnh mới
            String fileName = oldCategory.getIcon();
            if (fileName != null) {
                File file = new File(Constant.DIR + File.separator + fileName);
                if (file.exists()) file.delete();
            }
            oldCategory.setIcon(newCategory.getIcon());
        }
        categoryDao.edit(oldCategory);
    }

    @Override
    public void delete(int id) {
        CategoryModel oldCategory = categoryDao.get(id);
        if (oldCategory != null && oldCategory.getIcon() != null) {
            File file = new File(Constant.DIR + File.separator + oldCategory.getIcon());
            if (file.exists()) file.delete();
        }
        categoryDao.delete(id);
    }

    @Override
    public CategoryModel get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public List<CategoryModel> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<CategoryModel> search(String keyword) {
        return categoryDao.search(keyword);
    }
}