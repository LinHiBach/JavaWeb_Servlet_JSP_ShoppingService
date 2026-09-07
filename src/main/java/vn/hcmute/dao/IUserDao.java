package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.User;

public interface IUserDao {
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    User findByCodeAndEmail(String code, String email);
    List<User> findAll();
    void insert(User user);
    void update(User user);
    void delete(int id);

    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    User get(String username);
}
