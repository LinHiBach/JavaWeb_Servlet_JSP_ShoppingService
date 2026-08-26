package vn.hcmute.services.impl;

import java.sql.Date;

import vn.hcmute.dao.IUserDao;
import vn.hcmute.dao.impl.UserDaoImpl;
import vn.hcmute.models.UserModel;
import vn.hcmute.services.IUserService;

public class UserServiceImpl implements IUserService {
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public UserModel login(String username, String password) {
        UserModel user = this.get(username);
        if (user != null && password != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public UserModel get(String username) {
        return userDao.get(username);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        
        // Mặc định roleid = 3 (Member/User)
        UserModel newUser = new UserModel(email, username, fullname, password, null, 3, phone, date);
        userDao.insert(newUser);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public void insert(UserModel user) {
        userDao.insert(user);
    }
}
