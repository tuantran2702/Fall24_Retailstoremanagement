/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Product;
import model.Supplier;

/**
 *
 * @author admin
 */
public class SupplierDAO extends DBContext {

    public ArrayList<Supplier> getListsupplier() {
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
//        public static void main(String[] args) {
//        System.out.println();
//        SupplierDAO s =new SupplierDAO();
//        System.out.println(s.getListsupplier());
//    }

    public void createSupplier(Supplier supplier) {
        String sql = "INSERT INTO [dbo].[Supplier]\n" +
"           ([SupplierName]\n" +
"           ,[ContactName]\n" +
"           ,[PhoneNumber]\n" +
"           ,[Email]\n" +
"           ,[Address])\n" +
"     VALUES(?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
                        stmt.setString(1, supplier.getSupplierName());
            stmt.setString(2, supplier.getContactName());
            stmt.setString(3, supplier.getPhoneNumber());
            stmt.setString(4, supplier.getEmail());
            stmt.setString(5, supplier.getAddress());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
        }
        
    }
   public ArrayList<Product> setsupplier(int id)
   {
       
       ArrayList<Product> data = new ArrayList<>();
        String sql = "select * from Product p where p.SupplierID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
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

                data.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
       
   }
   
//       public static void main(String[] args) {
//        System.out.println();
//        SupplierDAO p =new SupplierDAO();
//        System.out.println(p.setsupplier(1));
//    }
public void deletesupplier(int id) {
    // Cập nhật bảng Product, đặt SupplierID về NULL cho các sản phẩm có SupplierID là nhà cung cấp đang bị xóa
    String updateProductSql = "UPDATE [dbo].[Product] SET SupplierID = NULL WHERE SupplierID = ?";

    // Xóa nhà cung cấp khỏi bảng Supplier
    String deleteSupplierSql = "DELETE FROM [dbo].[Supplier] WHERE SupplierID = ?";

    try {
        // Bắt đầu cập nhật bảng Product
        PreparedStatement updateProductSt = connection.prepareStatement(updateProductSql);
        updateProductSt.setInt(1, id);
        updateProductSt.executeUpdate();

        // Sau đó xóa nhà cung cấp
        PreparedStatement deleteSupplierSt = connection.prepareStatement(deleteSupplierSql);
        deleteSupplierSt.setInt(1, id);
        deleteSupplierSt.executeUpdate();

    } catch (Exception e) {
        System.out.println("DeleteFail:" + e.getMessage());
    }
}
   
//    public void deletesupplier(int id) {
//
//        String sql = "DELETE FROM [dbo].[Supplier]\n" +
//"      WHERE SupplierID=?";
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            st.setInt(1, id);
//            ResultSet rs = st.executeQuery();
//
//        } catch (Exception e) {
//            System.out.println("DeleteFail:" + e.getMessage());
//        }
//
//    }

    public Supplier getSupplierById(int id) {
                String sql = "select *from Supplier where SupplierID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String supplierName = rs.getString(2);
                String contactName = rs.getString(3);
                String phoneNumber = rs.getString(4);
                String email = rs.getString(5);
                String address = rs.getString(6);

                return new Supplier(id, supplierName, contactName, phoneNumber, email, address);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateSupplier(Supplier supplier) {
        
        String sql = "UPDATE Supplier SET"
                + " SupplierName = ?,"
                        + " ContactName = ?,"
                        + " PhoneNumber = ?,"
                        + " Email = ?,"
                        + " Address = ? WHERE SupplierID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, supplier.getSupplierName());
            stmt.setString(2, supplier.getContactName());
            stmt.setString(3, supplier.getPhoneNumber());
            stmt.setString(4, supplier.getEmail());
            stmt.setString(5, supplier.getAddress());
            stmt.setInt(6, supplier.getSupplierID());


            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
        }

    }

    public void addSupplierName(Supplier supplier) {
        String sql = "INSERT INTO Supplier (SupplierName) VALUES (?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, supplier.getSupplierName());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


}
