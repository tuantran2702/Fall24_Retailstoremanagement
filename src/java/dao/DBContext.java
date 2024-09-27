
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
public class DBContext {
    
    public Connection connection;
    
    public DBContext()
    {
        try{
            String user = "sa";
            String pass = "123456";
            String url = "jdbc:sqlserver://TRUNG:1433;databaseName=RetailStoreDatabase1;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("Kết nối thành công!");
            
        }catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Kết nối thất bại!");
        }
    }
    
}
