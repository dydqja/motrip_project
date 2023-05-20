package com.bit.motrip.dao.memo;

import com.bit.motrip.common.TestUtil;
import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import java.util.List;
@SpringBootTest
class MemoDaoTest {
    @Autowired
    private MemoDao memoDao;

    //methods to test


    //insert test
    @Test
    void addMemo(){
        //입력할 메모를 만든다.
        Memo memo = TestUtil.temporaryMemoMaker();
        //DB에 메모를 추가한다.
        try {
            int isSuccess = memoDao.addMemo(memo);
        }catch (Exception e){
            e.printStackTrace();
        }
        try{
            int maxNo = memoDao.getMaxMemoNo();
            System.out.println("추가된 메모의 번호는 "+maxNo+"입니다.");

            //DB에 삽입된 메모의 memo_user_access 추가한다.
            MemoAccess memoAccess = new MemoAccess(maxNo,memo.getMemoAuthor(),true);
            memoDao.addMemoAccess(memoAccess);
            int maxAccessNo = memoDao.getMaxMemoAccessNo();
            System.out.println("추가된 메모의 접근번호는 "+maxAccessNo+"입니다.");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void getMemo(){
        Memo memo = new Memo();
        int targetMemoNo= 1;
        try {
            memo = memoDao.getMemo(targetMemoNo);
            System.out.println(memo.getMemoTitle());
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void deleteMemo() throws Exception{
        int targetMemoNo = 4;
        try{
            memoDao.deleteMemo(targetMemoNo);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void updateMemo() throws Exception{
        Memo memo = new Memo();
        memo.setMemoNo(2);
        memo.setMemoTitle("오늘의 코딩일지");
        memo.setMemoContents("오늘은 마이바티스를 죽였다. 내일은 비트캠프를 불태울 것이다.");
        memo.setMemoColor(1);
        memoDao.updateMemo(memo);
    }
    @Test
    //select list test
    void getMemoList() throws Exception{
        List<Memo> memoList = memoDao.getMemoList("user1");
        for(Memo memo : memoList){
            System.out.println(memo.getMemoTitle());
        }
    }

}