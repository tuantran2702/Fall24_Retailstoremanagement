
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
            String pass = "123456789";
            String url = "jdbc:sqlserver://LAPTOP-SPMOG9TV:1433;databaseName=RetailStoreDatabase1";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        }catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
