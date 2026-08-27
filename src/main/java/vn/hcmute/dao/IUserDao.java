package vn.hcmute.dao;

import java.util.List;
import vn.hcmute.entity.User;
import vn.hcmute.models.UserModel;

public interface IUserDao {
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
    void insert(User user);
    void update(User user);
    void delete(int id);

    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    // Aliases for compatibility
    UserModel get(String username);
    void insert(UserModel user);
}
