package com.bit.motrip.dao.memo;

import com.bit.motrip.domain.Memo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
class MemoDaoTest {
    @Autowired
    private MemoDao memoDao;

    //insert test
    @Test
    void addMemo() throws Exception{
        Memo memo = new Memo();
        memo.setMemoTitle("test2");
        memo.setMemoContents("testtest");
        memo.setMemoColor(0);
        int afterMemoNo = memoDao.addMemo(memo);
        System.out.println(afterMemoNo);
    }
    @Test
    //select test
    void getMemo() throws Exception{

        Memo memo = new Memo();
        int targetMemoNo= 1;
        memo = memoDao.getMemo(targetMemoNo);
        System.out.println(memo.getMemoTitle());
    }
}