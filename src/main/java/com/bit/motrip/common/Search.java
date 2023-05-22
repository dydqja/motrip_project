package com.bit.motrip.common;

public class Search {

    //Field
    private int currentPage;
    private String searchCondition;
    private int[] searchConditions;
    private String searchKeyword;
    private int pageSize;
    private int endRowNum;
    private int startRowNum;

    //Constructor
    public Search() {

    }

    //Method
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public String getSearchCondition() {
        return searchCondition;
    }
    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public int getEndRowNum() {
        return getCurrentPage()*getPageSize();
    }

    public int getStartRowNum() {
        return (getCurrentPage()-1)*getPageSize()+1;
    }

    public int[] getSearchConditions() {
        return searchConditions;
    }

    public void setSearchConditions(int[] searchConditions) {
        this.searchConditions = searchConditions;
    }

    @Override
    public String toString() {
        return "Search{" +
                "currentPage=" + currentPage +
                ", searchCondition='" + searchCondition + '\'' +
                ", searchKeyword='" + searchKeyword + '\'' +
                ", pageSize=" + pageSize +
                ", endRowNum=" + endRowNum +
                ", startRowNum=" + startRowNum +
                '}';
    }
}
