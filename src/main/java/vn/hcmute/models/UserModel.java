package vn.hcmute.models;

import java.sql.Date;
import vn.hcmute.entity.User;

public class UserModel extends User {
    private static final long serialVersionUID = 1L;

    public UserModel() {
        super();
    }

    public UserModel(int id, String email, String username, String fullname, String password, String avatar, int roleid,
            String phone, Date createdDate) {
        super(id, email, username, fullname, password, avatar, roleid, phone, createdDate);
    }

    public UserModel(String email, String username, String fullname, String password, String avatar, int roleid,
            String phone, Date createdDate) {
        super(email, username, fullname, password, avatar, roleid, phone, createdDate);
    }

    public UserModel(User user) {
        if (user != null) {
            this.setId(user.getId());
            this.setEmail(user.getEmail());
            this.setUsername(user.getUsername());
            this.setFullname(user.getFullname());
            this.setPassword(user.getPassword());
            this.setAvatar(user.getAvatar());
            this.setRoleid(user.getRoleid());
            this.setPhone(user.getPhone());
            this.setCreatedDate(user.getCreatedDate());
        }
    }
}
