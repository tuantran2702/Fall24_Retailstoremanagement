/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.*;
import model.Voucher;
import java.sql.*;

/**
 *
 * @author ptrung
 */
public class VoucherDAO extends DBContext {

    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Voucher v = new Voucher();
                v.setVoucherID(rs.getInt(1));
                v.setDiscountID(rs.getInt(2));
                v.setOrderID(rs.getInt(3));
                v.setVoucherCode(rs.getString(4));
                v.setExpirationDate(rs.getDate(5));

                vouchers.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vouchers;
    }

}
