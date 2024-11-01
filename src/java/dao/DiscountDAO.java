/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.*;
import model.Discount;
import java.sql.*;


public class DiscountDAO extends DBContext{
    
    public List<Discount> getAllDiscounts() {
    List<Discount> discounts = new ArrayList<>();
    String sql = "SELECT * FROM Discount";

    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            Discount d = new Discount();
            d.setDiscountID(rs.getInt(1));
            d.setProductID(rs.getInt(2));
            d.setDiscountName(rs.getString(3));
            d.setDiscountPercent(rs.getDouble(4));
            d.setStartDate(rs.getDate(5));
            d.setEndDate(rs.getDate(6));
            d.setDescription(rs.getString(7));

            discounts.add(d);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return discounts;
}

}
