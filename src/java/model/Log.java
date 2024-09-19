package model;

import java.util.Date;

public class Log {
    private int logID;
    private Date logDate;
    private Integer userID; // Using Integer for nullable values
    private String actionType;
    private String tableName;
    private Integer recordID; // Using Integer for nullable values
    private String description;

    // Constructors, getters, and setters
    public Log() {}

    public Log(int logID, Date logDate, Integer userID, String actionType, String tableName, Integer recordID, String description) {
        this.logID = logID;
        this.logDate = logDate;
        this.userID = userID;
        this.actionType = actionType;
        this.tableName = tableName;
        this.recordID = recordID;
        this.description = description;
    }

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public Date getLogDate() {
        return logDate;
    }

    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Integer getRecordID() {
        return recordID;
    }

    public void setRecordID(Integer recordID) {
        this.recordID = recordID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
