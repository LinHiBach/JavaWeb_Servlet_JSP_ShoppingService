package vn.hcmute.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String portNumber = "1433";
    private final String dbName = "ShoppingServiceMVC";
    private final String userID = "sa";
    private final String password = "huy210906";

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                + ";databaseName=" + dbName
                + ";encrypt=true;trustServerCertificate=true;";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("====== KẾT NỐI SQL SERVER THÀNH CÔNG! ======");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("====== KẾT NỐI THẤT BẠI! ======");
            e.printStackTrace();
        }
    }
}
