package model;

public class CustomerRank {
    private int rankID;
    private String rankName;
    private double minimumSpent;
    private String description;
    private double discountPercent;  // Thêm thuộc tính mới

    // Constructors, getters, and setters
    public CustomerRank() {}

    public CustomerRank(int rankID, String rankName, double minimumSpent, String description, double discountPercent) {
        this.rankID = rankID;
        this.rankName = rankName;
        this.minimumSpent = minimumSpent;
        this.description = description;
        this.discountPercent = discountPercent;
    }

    public int getRankID() {
        return rankID;
    }

    public void setRankID(int rankID) {
        this.rankID = rankID;
    }

    public String getRankName() {
        return rankName;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    public double getMinimumSpent() {
        return minimumSpent;
    }

    public void setMinimumSpent(double minimumSpent) {
        this.minimumSpent = minimumSpent;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }
}
