package vn.hcmute.dao;

import vn.hcmute.models.UserModel;

public interface IUserDao {
    UserModel get(String username);
    void insert(UserModel user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}
