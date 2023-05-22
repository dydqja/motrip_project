package com.bit.motrip.dao.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.common.TestUtil;
import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
@SpringBootTest
class MemoDaoTest {
    @Autowired
    private MemoDao memoDao;
    @Value(value = "#{memo['listSize']}")
    private int listSize;

    //methods to test
    @Test
    void getListSize(){
        System.out.println(listSize);
    }



    //insert test
    @Test
    void addMemoTest(){
        //입력할 메모를 만든다.
        Memo memo = TestUtil.temporaryMemoMaker();
        //DB에 메모를 추가한다.
        int isSuccess = 0;
        try {
            isSuccess = memoDao.addMemo(memo);
        }catch (Exception e){
            e.printStackTrace();
        }
        if(isSuccess==1) {
            System.out.println("메모가 추가되었습니다.");
            try {
                System.out.println("추가된 메모의 내용은 "+memo+"입니다.");
                //DB에 삽입된 메모의 memo_user_access 추가한다.
                MemoAccess memoAccess = new MemoAccess(memo.getMemoNo(), memo.getMemoAuthor(), true);
                int isSuccess2 = 0;
                isSuccess2 =  memoDao.addMemoAccess(memoAccess);
                if(isSuccess2==1) {
                    System.out.println("추가된 메모의 접근권한 내용은 " + memoAccess + "입니다.");
                }
                else{
                    System.out.println("메모의 접근권한이 추가되지 않았습니다.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else{
            System.out.println("메모가 추가되지 않았습니다.");
        }
    }
    @Test
    void getMemoTest(){
        Memo memo = new Memo();
        int targetMemoNo= 1;
        try {
            memo = memoDao.getMemo(targetMemoNo);
            System.out.println(memo);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void deleteMemoTest(){
        int targetMemoNo = 36;
        String userId = "user1";
        try{
            int isSuccess = memoDao.deleteMemo(targetMemoNo,userId);
            if(isSuccess==1){
                System.out.println("메모가 삭제되었습니다.");
            }
            else{
                System.out.println("메모가 삭제되지 않았습니다. 혹시 주인이 아니신지?");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void updateMemoTest(){
        int resultNo = 0;
        Memo memo = new Memo();
        memo.setMemoNo(6);
        memo.setMemoTitle("오늘의 코딩일지");
        memo.setMemoContents("오늘은 마이바티스를 죽였다. 내일은 비트캠프를 불태울 것이다.");
        memo.setMemoColor(1);
        try{
           resultNo = memoDao.updateMemo(memo);
              if(resultNo==1){
                System.out.println("메모가 수정되었습니다.");
                memo = memoDao.getMemo(memo.getMemoNo());
                  System.out.println("수정된 메모의 내용은 "+memo+"입니다.");
              }
              else{
                System.out.println("메모가 수정되지 않았습니다.");
              }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    //select list test
    void getMemoListTest() throws Exception{
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(10);
        //searchConditions : 1-다른 사람에게서 공유받은 메모까지 봄, 1-다른 문서에 부착된 메모까지 봄
        search.setSearchConditions(new int[] {0,1});
        search.setSearchKeyword("user1");

        //일단은 싹들고와
        List<Memo> memoList = memoDao.getMemoList(search);
        for(Memo memo : memoList){
            System.out.println(memo);
        }

    }
    @Test
    void addMemoAccessTest() throws Exception{
        MemoAccess memoAccess = new MemoAccess();
        memoAccess.setMemoNo(1);
        memoAccess.setMemoAccessUser("admin");
        memoAccess.setMemoAuthor(false);
        int isSuccess = memoDao.addMemoAccess(memoAccess);
        if(isSuccess==1){
            System.out.println("메모 접근권한이 추가되었습니다.");
            System.out.println("추가된 메모 접근권한의 내용은 "+memoAccess+"입니다.");
        }
        else{
            System.out.println("메모 접근권한이 추가되지 않았습니다.");
        }
    }
    @Test
    void deleteMemoAccessTest(){
        MemoAccess memoAccess = new MemoAccess();
        memoAccess.setMemoAccessUser("admin");
        memoAccess.setMemoNo(1);
        int isSuccess = 0;
        try {
            isSuccess = memoDao.deleteMemoAccess(memoAccess);
            if(isSuccess==1){
                System.out.println("메모 접근권한이 삭제되었습니다.");
                System.out.println("삭제된 메모 접근권한의 내용은 "+memoAccess+"입니다.");
            }
            else{
                System.out.println("메모 접근권한이 삭제되지 않았습니다.");
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
    @Test
    void getMemoAccessListByMemoNoTest() throws Exception{
        int targetMemoNo = 1;
        List<MemoAccess> memoAccessList = memoDao.getMemoAccessListByMemoNo(targetMemoNo);
        int count = 0;
        for(MemoAccess memoAccess : memoAccessList){
            System.out.println(count+"번 리스트의 내용은 "+memoAccess);
            count++;
        }
    }
    @Test
    void getMemoAccessListByUserIdTest() throws Exception{
        String targetUserId = "user1";
        List<MemoAccess> memoAccessList = memoDao.getMemoAccessListByUserId(targetUserId);
        int count = 0;
        for(MemoAccess memoAccess : memoAccessList){
            System.out.println(count+"번 리스트의 내용은 "+memoAccess);
            count++;
        }
    }




}