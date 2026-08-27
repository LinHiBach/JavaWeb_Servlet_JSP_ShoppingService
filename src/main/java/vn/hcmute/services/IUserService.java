package vn.hcmute.services;

import java.util.List;
import vn.hcmute.entity.User;
import vn.hcmute.models.UserModel;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    List<User> findAll();
    void insert(User user);
    void update(User user);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    void insert(UserModel user);
}
