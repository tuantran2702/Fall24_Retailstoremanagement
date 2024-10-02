package model;

public class CustomerRank {
    private int rankID;
    private String rankName;
    private double minimumSpent;
    private String description;

    // Constructors, getters, and setters
    public CustomerRank() {}

    public CustomerRank(int rankID, String rankName, double minimumSpent, String description) {
        this.rankID = rankID;
        this.rankName = rankName;
        this.minimumSpent = minimumSpent;
        this.description = description;
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
}
