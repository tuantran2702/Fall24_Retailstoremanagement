/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Category;
import model.Product;
import model.Supplier;
import model.Unit;
import model.User;
import org.apache.tomcat.dbcp.dbcp2.PStmtKey;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    public  List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "select p.*,c.CategoryName from Product p join Category c on p.CategoryID=c.CategoryID";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt(1);
                String productCode = rs.getString(2);
                String productName = rs.getString(3);
                int categoryID = rs.getInt(4);
                double price = rs.getDouble(5);
                int quantity = rs.getInt(6);
                String description = rs.getString(7);
                Date createdDate = rs.getDate(8);
                Date expiredDate = rs.getDate(9);
                Date updateDate = rs.getDate(10);
                String image = rs.getString(11);
                int userID = rs.getInt(12);
                int unitID = rs.getInt(13);
                int supplierID = rs.getInt(14);
                String categoryName = rs.getString(15);

                products.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID, categoryName));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;

    }

//    public boolean updateProduct(Product product) {
//        String sql = "UPDATE Warehouse SET WarehouseName = ?, Location = ?, ManagerName = ?, ContactNumber = ? WHERE WarehouseID = ?";
//        try {
//            PreparedStatement stmt = connection.prepareStatement(sql);
//            stmt.setString(1, product.getProductCode());
//            stmt.setString(2, product.getProductName());
//            stmt.setInt(3, product.getCategoryID());
//            stmt.setDouble(4, product.getPrice());
//            stmt.setInt(5, product.getQuantity());
//            stmt.setString(6, product.getDescription());
//            stmt.setDate(7, new java.sql.Date(product.getCreatedDate().getTime()));
//            stmt.setDate(8, new java.sql.Date(product.getExpiredDate().getTime()));
//            stmt.setDate(9, new java.sql.Date(product.getUpdateDate().getTime()));
//            stmt.setString(10, product.getImage());
//            stmt.setInt(11, product.getUserID());
//            stmt.setInt(12, product.getUnitID());
//            stmt.setInt(13, product.getSupplierID());
//            stmt.setInt(14, product.getProductID());
//
//            return stmt.executeUpdate() > 0;
//
//        } catch (SQLException e) {
//            System.out.println("insertFail:" + e.getMessage());
////            e.printStackTrace();
//        }
//        return false;
//    }
    public ArrayList<Product> getListProduct() {
        ArrayList<Product> data = new ArrayList<>();
        String sql = "select p.*,c.CategoryName from Product p join Category c on p.CategoryID=c.CategoryID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt(1);
                String productCode = rs.getString(2);
                String productName = rs.getString(3);
                int categoryID = rs.getInt(4);
                double price = rs.getDouble(5);
                int quantity = rs.getInt(6);
                String description = rs.getString(7);
                Date createdDate = rs.getDate(8);
                Date expiredDate = rs.getDate(9);
                Date updateDate = rs.getDate(10);
                String image = rs.getString(11);
                int userID = rs.getInt(12);
                int unitID = rs.getInt(13);
                int supplierID = rs.getInt(14);
                String categoryName = rs.getString(15);

                data.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID, categoryName));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;

    }

//    public ArrayList<Product> getListProduct() {
//        ArrayList<Product> data = new ArrayList<>();
//        String sql = "SELECT * FROM Product";
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                int productID = rs.getInt(1);
//                String productCode = rs.getString(2);
//                String productName = rs.getString(3);
//                int categoryID = rs.getInt(4);
//                double price = rs.getDouble(5);
//                int quantity = rs.getInt(6);
//                String description = rs.getString(7);
//                Date createdDate = rs.getDate(8);
//                Date expiredDate = rs.getDate(9);
//                Date updateDate = rs.getDate(10);
//                String image = rs.getString(11);
//                int userID = rs.getInt(12);
//                int unitID = rs.getInt(13);
//                int supplierID = rs.getInt(14);
//
//                data.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID));
//
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return data;
//    }
//lay categoryname theo category id
    public ArrayList<Category> GetListCategory() {
        ArrayList<Category> data = new ArrayList<>();
        String sql = "select * from Category";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int categoryID = rs.getInt(1);
                String categoryName = rs.getString(2);
                String description = rs.getString(3);
                data.add(new Category(categoryID, categoryName, description));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;

    }

    public ArrayList<Unit> GetListUnit() {
        ArrayList<Unit> data = new ArrayList<>();
        String sql = "select * from Unit";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int unitID = rs.getInt(1);
                String unitName = rs.getString(2);
                data.add(new Unit(unitID, unitName));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;

    }

    public ArrayList<Supplier> GetListSupplier() {
        ArrayList<Supplier> data = new ArrayList<>();
        String sql = "select * from Supplier";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int supplierID = rs.getInt(1);
                String supplierName = rs.getString(2);
                String contactName = rs.getString(3);
                String phoneNumber = rs.getString(4);
                String email = rs.getString(5);
                String address = rs.getString(6);

                data.add(new Supplier(supplierID, supplierName, contactName, phoneNumber, email, address));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;

    }

    public ArrayList<User> GetListUser() {
        ArrayList<User> data = new ArrayList<>();
        String sql = "select * from [dbo].[User]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int userID=rs.getInt(1);
                String firstName =rs.getString(2);
                String lastName=rs.getString(3);
                String email=rs.getString(4);
                String password=rs.getString(5);
                String phoneNumber=rs.getString(6);
                String address=rs.getString(7);
                String img=rs.getString(8);
                int roleID =rs.getInt(9);
                
                data.add(new User(userID, firstName, lastName, email, password, phoneNumber, address, roleID, img));
                        
                            


            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
        

    }
//    public static void main(String[] args) {
//        System.out.println();
//        ProductDAO p =new ProductDAO();
//        System.out.println(p.GetListUser());
//    }
    public void createProduct(Product product) {
            String sql = "INSERT INTO [dbo].[Product]\n"
                    + "           ([ProductCode]\n"
                    + "           ,[ProductName]\n"
                    + "           ,[CategoryID]\n"
                    + "           ,[Price]\n"
                    + "           ,[Quantity]\n"
                    + "           ,[Description]\n"
                    + "           ,[CreatedDate]\n"
                    + "           ,[ExpiredDate]\n"
                    + "           ,[UpdateDate]\n"
                    + "           ,[Image]\n"
                    + "           ,[UserID]\n"
                    + "           ,[UnitID]\n"
                    + "           ,[SupplierID]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try {
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, product.getProductCode());
                stmt.setString(2, product.getProductName());
                stmt.setInt(3, product.getCategoryID());
                stmt.setDouble(4, product.getPrice());
                stmt.setInt(5, product.getQuantity());
                stmt.setString(6, product.getDescription());
                stmt.setDate(7, new java.sql.Date(product.getCreatedDate().getTime()));
                stmt.setDate(8, new java.sql.Date(product.getExpiredDate().getTime()));
                stmt.setDate(9, new java.sql.Date(product.getUpdateDate().getTime()));
                stmt.setString(10, product.getImage());
                stmt.setInt(11, product.getUserID());
                stmt.setInt(12, product.getUnitID());
                stmt.setInt(13, product.getSupplierID());

                stmt.executeUpdate();

            } catch (SQLException e) {
                System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
            }

      

    }

    public Product getProductById(int id) {
        String sql = "select * from Product where ProductID= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String productCode = rs.getString(2);
                String productName = rs.getString(3);
                int categoryID = rs.getInt(4);
                double price = rs.getDouble(5);
                int quantity = rs.getInt(6);
                String description = rs.getString(7);
                Date createdDate = rs.getDate(8);
                Date expiredDate = rs.getDate(9);
                Date updateDate = rs.getDate(10);
                String image = rs.getString(11);
                int userID = rs.getInt(12);
                int unitID = rs.getInt(13);
                int supplierID = rs.getInt(14);

                return new Product(id, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public void updateProduct(Product product) {
        int importInventory = getInventoryQuantityByProductId(product.getProductID());
        if (product.getQuantity() <= importInventory) {
            String sql = "UPDATE Product SET ProductCode = ?,"
                    + " ProductName = ?,"
                    + " CategoryID = ?,"
                    + " Price = ?,"
                    + " Quantity = ?,"
                    + " Description = ?,"
                    + "CreatedDate = ?,"
                    + " ExpiredDate = ?,"
                    + " UpdateDate = ?,"
                    + " Image = ?,"
                    + " UserID = ?,"
                    + " UnitID = ?,"
                    + " SupplierID = ? WHERE ProductID = ?";
            try {
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, product.getProductCode());
                stmt.setString(2, product.getProductName());
                stmt.setInt(3, product.getCategoryID());
                stmt.setDouble(4, product.getPrice());
                stmt.setInt(5, product.getQuantity());
                stmt.setString(6, product.getDescription());
                stmt.setDate(7, new java.sql.Date(product.getCreatedDate().getTime()));
                stmt.setDate(8, new java.sql.Date(product.getExpiredDate().getTime()));
                stmt.setDate(9, new java.sql.Date(product.getUpdateDate().getTime()));
                stmt.setString(10, product.getImage());
                stmt.setInt(11, product.getUserID());
                stmt.setInt(12, product.getUnitID());
                stmt.setInt(13, product.getSupplierID());
                stmt.setInt(14, product.getProductID());

                stmt.executeUpdate();

            } catch (SQLException e) {
                System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
            }

        } else {
            System.out.println("Error: Product quantity exceeds Inventory quantity.");
        }

    }
//            public static void main(String[] args) {
//        System.out.println();
//        ProductDAO p =new ProductDAO();
//        System.out.println(p.updateProduct(Product));
//    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM [dbo].[Product] WHERE ProductID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

        } catch (Exception e) {
            System.out.println("DeleteFail:" + e.getMessage());
        }

    }


    public int getInventoryQuantityByProductId(int productID) {
        String query = "select Quantity from Inventory where ProductID=?";
        try {
            PreparedStatement pstm = connection.prepareStatement(query);
            pstm.setInt(1, productID);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;

    }

}