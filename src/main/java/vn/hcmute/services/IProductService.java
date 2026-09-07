package vn.hcmute.services;

import java.util.List;
import vn.hcmute.entity.Product;

public interface IProductService {
    Product findById(int id);
    List<Product> findAll();
    List<Product> findTop10Newest();
    List<Product> findAllPaged(int page, int pageSize);
    List<Product> findByCategoryIdPaged(int categoryId, int page, int pageSize);
    List<Product> searchByName(String keyword);
    int countAll();
    int countByCategoryId(int categoryId);
    void insert(Product product);
    void update(Product product);
    void delete(int id);
}
