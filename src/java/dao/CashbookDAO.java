package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Cashbook;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class CashbookDAO extends DBContext {

    public ArrayList<Cashbook> getListCashbook() {
        ArrayList<Cashbook> data = new ArrayList<>();
        String sql = "SELECT * FROM Cashbook ORDER BY TransactionDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Cashbook cashbook = mapResultSetToCashbook(rs);
                data.add(cashbook);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public Cashbook getCashbookById(int id) {
        String sql = "SELECT * FROM Cashbook WHERE TransactionID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return mapResultSetToCashbook(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public BigDecimal getCurrentBalance() {
        String sql = "SELECT TOP 1 Balance FROM Cashbook ORDER BY TransactionDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("Balance");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
 public void createCashbook(Cashbook cashbook) {
        String sql = "INSERT INTO Cashbook (TransactionDate, Description, Amount, TransactionType, Balance, InitialBalance, OrderID, ImportID) "
                  + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setTimestamp(1, cashbook.getTransactionDate());
            st.setString(2, cashbook.getDescription());
            st.setBigDecimal(3, cashbook.getAmount());
            st.setString(4, cashbook.getTransactionType());
            st.setBigDecimal(5, cashbook.getBalance());
            st.setBigDecimal(6, cashbook.getInitialBalance());
            setNullableInteger(st, 7, cashbook.getOrderID());
            setNullableInteger(st, 8, cashbook.getImportID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

     public void updateCashbook(Cashbook cashbook) {
        String sql = "UPDATE Cashbook SET TransactionDate = ?, Description = ?, Amount = ?, "
                  + "TransactionType = ?, Balance = ?, InitialBalance = ?, OrderID = ?, ImportID = ? "
                  + "WHERE TransactionID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setTimestamp(1, cashbook.getTransactionDate());
            st.setString(2, cashbook.getDescription());
            st.setBigDecimal(3, cashbook.getAmount());
            st.setString(4, cashbook.getTransactionType());
            st.setBigDecimal(5, cashbook.getBalance());
            st.setBigDecimal(6, cashbook.getInitialBalance());
            setNullableInteger(st, 7, cashbook.getOrderID());
            setNullableInteger(st, 8, cashbook.getImportID());
            st.setInt(9, cashbook.getTransactionID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCashbook(int id) {
        String sql = "DELETE FROM Cashbook WHERE TransactionID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Cashbook> searchCashbook(String searchTerm, String transactionType, 
                                            Timestamp startDate, Timestamp endDate) {
        ArrayList<Cashbook> data = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Cashbook WHERE 1=1");
        ArrayList<Object> params = new ArrayList<>();

        if (searchTerm != null && !searchTerm.isEmpty()) {
            sql.append(" AND Description LIKE ?");
            params.add("%" + searchTerm + "%");
        }
        if (transactionType != null && !transactionType.isEmpty()) {
            sql.append(" AND TransactionType = ?");
            params.add(transactionType);
        }
        if (startDate != null) {
            sql.append(" AND TransactionDate >= ?");
            params.add(startDate);
        }
        if (endDate != null) {
            sql.append(" AND TransactionDate <= ?");
            params.add(endDate);
        }

        sql.append(" ORDER BY TransactionDate DESC");

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof String) {
                    st.setString(i + 1, (String) params.get(i));
                } else if (params.get(i) instanceof Timestamp) {
                    st.setTimestamp(i + 1, (Timestamp) params.get(i));
                }
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                data.add(mapResultSetToCashbook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    private Cashbook mapResultSetToCashbook(ResultSet rs) throws SQLException {
        return new Cashbook(
            rs.getInt("TransactionID"),
            rs.getTimestamp("TransactionDate"),
            rs.getString("Description"),
            rs.getBigDecimal("Amount"),
            rs.getString("TransactionType"),
            rs.getBigDecimal("Balance"),
            rs.getBigDecimal("InitialBalance"), // Lấy giá trị initialBalance từ kết quả truy vấn
            rs.getObject("OrderID") != null ? rs.getInt("OrderID") : null,
            rs.getObject("ImportID") != null ? rs.getInt("ImportID") : null
        );
    }

    private void setNullableInteger(PreparedStatement st, int parameterIndex, Integer value) throws SQLException {
        if (value == null) {
            st.setNull(parameterIndex, java.sql.Types.INTEGER);
        } else {
            st.setInt(parameterIndex, value);
        }
    }
 // Thêm phương thức updateInitialBalance
 public boolean updateInitialBalance(BigDecimal initialBalance) {
        String sql = "UPDATE Cashbook SET InitialBalance = ? WHERE TransactionID = (SELECT MIN(TransactionID) FROM Cashbook)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBigDecimal(1, initialBalance);
            int result = st.executeUpdate();
            
            if (result > 0) {
                // Cập nhật lại Balance cho tất cả các giao dịch
                updateAllBalances();
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error updating initial balance: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
private void updateAllBalances() {
        String sql = "UPDATE Cashbook c1 " +
                     "SET Balance = (SELECT c2.InitialBalance + " +
                     "    (SELECT COALESCE(SUM(CASE WHEN TransactionType = 'Thu' THEN Amount ELSE -Amount END), 0) " +
                     "     FROM Cashbook c3 " +
                     "     WHERE c3.TransactionID <= c1.TransactionID AND c3.TransactionID > (SELECT MIN(TransactionID) FROM Cashbook)) " +
                     "FROM Cashbook c2 WHERE c2.TransactionID = (SELECT MIN(TransactionID) FROM Cashbook))";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating balances: " + e.getMessage());
            e.printStackTrace();
        }
    }
    public BigDecimal getInitialBalance() {
        String sql = "SELECT InitialBalance FROM Cashbook WHERE TransactionID = (SELECT MIN(TransactionID) FROM Cashbook)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("InitialBalance");
            }
        } catch (SQLException e) {
            System.out.println("Error getting initial balance: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getTotalIncome() {
        String sql = "SELECT COALESCE(SUM(Amount), 0) AS TotalIncome FROM Cashbook WHERE TransactionType = 'Thu'";
        return getTotal(sql);
    }

    public BigDecimal getTotalExpense() {
        String sql = "SELECT COALESCE(SUM(Amount), 0) AS TotalExpense FROM Cashbook WHERE TransactionType = 'Chi'";
        return getTotal(sql);
    }

    private BigDecimal getTotal(String sql) {
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            System.out.println("Error getting total: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
public boolean resetCashbook() {
        String deleteAllTransactions = "DELETE FROM Cashbook";
        String insertInitialTransaction = "INSERT INTO Cashbook (TransactionDate, Description, Amount, TransactionType, Balance, InitialBalance) VALUES (?, 'Initial Balance', ?, 'Thu', ?, ?)";
        
        try {
            connection.setAutoCommit(false);
            
            // Delete all transactions
            PreparedStatement deleteStmt = connection.prepareStatement(deleteAllTransactions);
            deleteStmt.executeUpdate();
            
            // Insert a new initial transaction with zero balance
            PreparedStatement insertStmt = connection.prepareStatement(insertInitialTransaction);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            BigDecimal zeroBalance = BigDecimal.ZERO;
            
            insertStmt.setTimestamp(1, currentTimestamp);
            insertStmt.setBigDecimal(2, zeroBalance);
            insertStmt.setBigDecimal(3, zeroBalance);
            insertStmt.setBigDecimal(4, zeroBalance);
            
            insertStmt.executeUpdate();
            
            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                System.out.println("Error rolling back transaction: " + rollbackEx.getMessage());
            }
            System.out.println("Error resetting cashbook: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException autoCommitEx) {
                System.out.println("Error setting auto-commit: " + autoCommitEx.getMessage());
            }
        }
    }

    
  

}



