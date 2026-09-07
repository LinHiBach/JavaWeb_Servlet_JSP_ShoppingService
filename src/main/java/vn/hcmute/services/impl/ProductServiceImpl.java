package vn.hcmute.services.impl;

import java.util.List;
import vn.hcmute.dao.IProductDao;
import vn.hcmute.dao.impl.ProductDaoImpl;
import vn.hcmute.entity.Product;
import vn.hcmute.services.IProductService;

public class ProductServiceImpl implements IProductService {
    private final IProductDao productDao = new ProductDaoImpl();

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public List<Product> findTop10Newest() {
        return productDao.findTop10Newest();
    }

    @Override
    public List<Product> findAllPaged(int page, int pageSize) {
        return productDao.findAllPaged(page, pageSize);
    }

    @Override
    public List<Product> findByCategoryIdPaged(int categoryId, int page, int pageSize) {
        return productDao.findByCategoryIdPaged(categoryId, page, pageSize);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }

    @Override
    public int countByCategoryId(int categoryId) {
        return productDao.countByCategoryId(categoryId);
    }

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }
}
