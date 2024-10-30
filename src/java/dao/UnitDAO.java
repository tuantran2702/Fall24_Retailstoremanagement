/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Unit;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author admin
 */
public class UnitDAO extends DBContext{

    public void addUnitName(Unit unit) {
                        String sql = "INSERT INTO Unit (UnitName) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, unit.getUnitName());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public ArrayList<Unit> getListunit() {
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
    
}