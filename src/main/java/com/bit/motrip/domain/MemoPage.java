package com.bit.motrip.domain;

import com.bit.motrip.common.Search;

import java.util.List;

public class MemoPage {
    private String searchCondition;
    private int currentPage;
    private int dialogCount;

    private List<Integer> dialogNos;
    private List<MemoDoc> memoDocList;

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public List<MemoDoc> getMemoDocList() {
        return memoDocList;
    }

    public void setMemoDocList(List<MemoDoc> memoDocList) {
        this.memoDocList = memoDocList;
    }

    public int getDialogCount() {
        return dialogCount;
    }

    public void setDialogCount(int dialogCount) {
        this.dialogCount = dialogCount;
    }
}
