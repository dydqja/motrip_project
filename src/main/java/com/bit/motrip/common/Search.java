package com.bit.motrip.common;

public class Search {

    //Field
    private int currentPage;
    private String searchCondition;
    private int[] searchConditions;
    private String loginConditions;
    private String searchKeyword;
    private int pageSize;
    private int endRowNum;
    private int startRowNum;

    private int mysqlStartRowNum;
    private int limit; // 한화면에 몇개를 보여줄지
    private int offset; // 리스트 어디부터 보여줄지
    private int totalCount; // 리스트 총 갯수


    //Constructor
    public Search() {

    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
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

    public String getLoginConditions() {
        return loginConditions;
    }

    public void setLoginConditions(String loginConditions) {
        this.loginConditions = loginConditions;
    }

    public int getMysqlStartRowNum() {
        return (getCurrentPage()-1)*getPageSize();
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
