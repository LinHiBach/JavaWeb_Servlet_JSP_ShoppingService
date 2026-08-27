package vn.hcmute.services.impl;

import java.sql.Date;
import java.util.List;
import vn.hcmute.dao.IUserDao;
import vn.hcmute.dao.impl.UserDaoImpl;
import vn.hcmute.entity.User;
import vn.hcmute.models.UserModel;
import vn.hcmute.services.IUserService;

public class UserServiceImpl implements IUserService {
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);

        // Mặc định roleid = 3 (Member/User)
        User newUser = new User(email, username, fullname, password, null, 3, phone, date);
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
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void insert(UserModel user) {
        userDao.insert((User) user);
    }
}
