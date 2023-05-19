package com.bit.motrip.dao.memo;

import com.bit.motrip.domain.Memo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class MemoDaoTest {
    @Autowired
    private MemoDao memoDao;

    //insert test
    @Test
    void addMemo() throws Exception{
        Memo memo = new Memo();
        memo.setMemoTitle("이거왜안됨");
        memo.setMemoContents("도저히모르겠네");
        memo.setMemoColor(0);
        int afterMemoNo = memoDao.addMemo(memo);
        System.out.println(afterMemoNo);
    }
    //SimpleCrud

    //@Test
    //select test
    void getMemo() throws Exception{

        Memo memo = new Memo();
        int targetMemoNo= 1;
        memo = memoDao.getMemo(targetMemoNo);
        System.out.println(memo.getMemoTitle());
    }
    //@Test
    //delete test
    void deleteMemo() throws Exception{
        int targetMemoNo = 4;
        memoDao.deleteMemo(targetMemoNo);
    }
    //@Test
    //update test
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

        List<Memo> memoList = memoDao.getMemoList();
        for(Memo memo : memoList){
            System.out.println(memo.getMemoTitle());
        }
    }

}