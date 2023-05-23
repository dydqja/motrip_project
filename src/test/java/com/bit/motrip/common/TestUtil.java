package com.bit.motrip.common;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;

public class TestUtil {
    public static Memo temporaryMemoMaker() {
        //입력할 메모를 만든다.
        Memo memo = new Memo();
        memo.setMemoTitle("이거왜안됨");
        memo.setMemoContents("도저히모르겠네");
        memo.setMemoColor(0);
        memo.setMemoAuthor("user1");
        //build temporary memoAccessUserList
/*        List<User> memoAccessUserList = new ArrayList<User>();
        User admin = new User();
        admin.setUserId("admin");
        User user1 = new User();
        user1.setUserId("user1");
        memoAccessUserList.add(admin);
        memoAccessUserList.add(user1);
        memo.setMemoAccessUserList(memoAccessUserList);*/
        return memo;
    }

    public static MemoAccess temporaryMemoAccessMaker() {
        MemoAccess memoAccess = new MemoAccess();
        memoAccess.setMemoNo(1);
        memoAccess.setMemoAccessUser("user1");
        memoAccess.setMemoAuthor(true);
        return memoAccess;
    }
}
