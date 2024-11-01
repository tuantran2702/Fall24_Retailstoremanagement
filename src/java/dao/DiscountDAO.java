/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.*;
import model.Discount;
import java.sql.*;
import model.Role;

public class DiscountDAO extends DBContext {

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

    public Discount getDiscountByID(int discountID) {
        Discount discount = null;
        try {
            String sql = "SELECT * FROM Discount WHERE DiscountID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, discountID);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                discount = new Discount();
                discount.setDiscountID(rs.getInt("DiscountID"));
                discount.setProductID(rs.getInt("ProductID"));
                discount.setDiscountName(rs.getString("DiscountName"));
                discount.setDiscountPercent(rs.getDouble("DiscountPercent"));
                discount.setStartDate(rs.getDate("StartDate"));
                discount.setEndDate(rs.getDate("EndDate"));
                discount.setDescription(rs.getString("Description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return discount;
    }

    

}
