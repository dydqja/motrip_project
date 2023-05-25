package com.bit.motrip.dao.memo;

import com.bit.motrip.common.Search;
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
    @Value(value = "#{memo['pageSize']}")
    private int pageSize;

    //methods to test
    @Test
    void getListSize(){
        System.out.println(pageSize);
    }



    //insert test
    @Test
    void addMemoTest(){
        //서비스로부터 메모를 받아올 것이다.
        Memo memo = new Memo();
        memo.setMemoTitle("이것은 삭제될 예정인 시한부 메모임");
        memo.setMemoContents("조인 너무 어려워요. 이번엔 유저2로 좀 해보겠음");
        memo.setMemoColor(1);
        memo.setMemoAuthor("admin");


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
                int isSuccess2 =  memoDao.addMemoAccess(memoAccess);
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
        int targetMemoNo= 42;
        try {
            Memo memo = memoDao.getMemo(targetMemoNo);
            System.out.println(memo);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void deleteMemoTest(){
        int targetMemoNo = 44;
        try{
            int isSuccess = memoDao.deleteMemo(targetMemoNo);
            if(isSuccess==1){
                System.out.println("메모가 삭제대기되었습니다.");
            }
            else{
                System.out.println("메모가 삭제되지 않았습니다. 스케쥴러가 실행하는데 이러는건 뭔가 이상합니다.");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void removeMemoTest(){
        int targetMemoNo = 36;
        String userId = "user1";
        try{
            int isSuccess = memoDao.removeMemo(targetMemoNo);
            if(isSuccess==1){
                System.out.println("메모가 완전삭제되었습니다.");
            }
            else{
                System.out.println("메모가 삭제되지 않았습니다. 스케쥴러가 실행하는데 이러는건 뭔가 이상합니다.");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @Test
    void restoreMemoTest(){
        int targetMemoNo = 44;
        try{
            int isSuccess = memoDao.deleteMemo(targetMemoNo);
            if(isSuccess==1){
                System.out.println("메모가 삭제대기되었습니다.");
            }
            else{
                System.out.println("메모가 삭제되지 않았습니다. 스케쥴러가 실행하는데 이러는건 뭔가 이상합니다.");
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
    void attachMemoTest(){
        int resultNo = 0;
        Memo memo = new Memo();
        memo.setMemoNo(40);
        memo.setAttachedTripPlanNo(2);
        try{
            resultNo = memoDao.updateMemoAttach(memo);
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
    void getMemoListByMyMemoTest() throws Exception{
        //서비스단에서 받을 내용
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(10);
        search.setSearchKeyword("admin");
        System.out.println("시작행"+search.getStartRowNum());
        System.out.println("종료행"+search.getEndRowNum());

        //목록 실행부
        List<Memo> memoList = memoDao.getMemoListByMyMemo(search);
        for(Memo memo : memoList){
            System.out.println(memo);
        }
    }
    @Test
    void getMemoListBySharedMemoTest() throws Exception {
        //서비스단에서 받을 내용
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(10);
        search.setSearchKeyword("admin");

        //목록 실행부
        List<Memo> memoList = memoDao.getMemoListBySharedMemo(search);
        for (Memo memo : memoList) {
            System.out.println(memo);
        }
    }
    @Test
    void getMemoListByDeletedMemoTest() throws Exception{
        //서비스단에서 받을 내용
        Search search = new Search();
        search.setCurrentPage(1);
        search.setPageSize(10);
        search.setSearchKeyword("admin");
        System.out.println("시작행"+search.getStartRowNum());
        System.out.println("종료행"+search.getEndRowNum());

        //목록 실행부
        List<Memo> memoList = memoDao.getMemoListByDeletedMemo(search);
        for(Memo memo : memoList){
            System.out.println(memo);
        }
    }


    //memoAccess test


    @Test
    void addMemoAccessTest() throws Exception{
        //서비스에서 받을 내용
        MemoAccess memoAccess = new MemoAccess();
        memoAccess.setMemoNo(44);
        memoAccess.setMemoAccessUser("user2");
        memoAccess.setMemoAuthor(false);

        //실행부
        int isSuccess = memoDao.addMemoAccess(memoAccess);
        if(isSuccess==1){
            System.out.println("메모 접근권한이 추가되었습니다.");
            System.out.println("추가된 메모 접근권한의 내용은 "+memoAccess+"입니다.");
        }
        else{
            System.out.println("메모 접근권한이 추가되지 않았습니다.");
        }
        //자기 자신에게 권한을 부여할 수 없는 기능을 서비스단에서 구현해야 쓰레기가 들어가지 않는다.
    }
    @Test
    void deleteMemoAccessTest(){
        //서비스단에서 받을 내용
        MemoAccess memoAccess = new MemoAccess();
        memoAccess.setMemoAccessUser("admin");
        memoAccess.setMemoNo(1);

        //실행부
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
        //서비스단에서 받을 내용
        int targetMemoNo = 44;

        //실행부
        List<MemoAccess> memoAccessList = memoDao.getMemoAccessListByMemoNo(targetMemoNo);
        int count = 0;
        for(MemoAccess memoAccess : memoAccessList){
            System.out.println(count+"번 리스트의 내용은 "+memoAccess);
            count++;
        }
    }



}//end of memoDaoTest