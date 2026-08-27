package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.Category;

public interface ICategoryDao {
    void insert(Category cate);
    void update(Category cate);
    void delete(int id);
    Category findById(int id);
    Category findByCategoryname(String name);
    List<Category> findAll();
    List<Category> searchByName(String keyword);
    List<Category> findAll(int page, int pagesize);
    int count();

    // Aliases for compatibility
    void edit(Category category);
    Category get(int id);
    List<Category> getAll();
    List<Category> search(String keyword);
}