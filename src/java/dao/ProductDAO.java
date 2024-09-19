/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import model.Product;

/**
 *
 * @author admin
 */
public class ProductDAO extends DBContext {

    public ArrayList<Product> getListProduct() {
        ArrayList<Product> data = new ArrayList<>();
        String sql = "SELECT * FROM Product";
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

                data.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

}
