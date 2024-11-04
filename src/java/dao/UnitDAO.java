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
public class UnitDAO extends DBContext {

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

    public void deleteUnit(int id) {
        // Cập nhật bảng Product, đặt SupplierID về NULL cho các sản phẩm có SupplierID là nhà cung cấp đang bị xóa
        String updateProductSql = "UPDATE [dbo].[Product] SET UnitID = NULL WHERE UnitID = ?";

        // Xóa nhà cung cấp khỏi bảng Supplier
        String deleteUnitSql = "DELETE FROM [dbo].[Unit]\n" +
"      WHERE UnitID= ?";

        try {
            // Bắt đầu cập nhật bảng Product
            PreparedStatement updateProductSt = connection.prepareStatement(updateProductSql);
            updateProductSt.setInt(1, id);
            updateProductSt.executeUpdate();

            // Sau đó xóa nhà cung cấp
            PreparedStatement deleteUnitSt = connection.prepareStatement(deleteUnitSql);
            deleteUnitSt.setInt(1, id);
            deleteUnitSt.executeUpdate();

        } catch (Exception e) {
            System.out.println("DeleteFail:" + e.getMessage());
        }

    }

    public void createUnit(Unit unit) {
                String sql = "INSERT INTO [dbo].[Unit]\n" +
"           ([UnitName])\n" +
"     VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, unit.getUnitName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("insertFail:" + e.getMessage());
        }

    }

    public Unit getUnitById(int id) {
                        String sql = "select *from Unit where UnitID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String unitName = rs.getString(2);

                return new Unit(id, unitName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public void updateUnit(Unit unit) {
        String sql = "UPDATE Unit SET UnitName = ? WHERE UnitID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, unit.getUnitName());
            stmt.setInt(2, unit.getUnitID());
            
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
        }

    }

}