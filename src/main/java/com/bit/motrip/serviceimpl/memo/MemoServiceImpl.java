package com.bit.motrip.serviceimpl.memo;

import com.bit.motrip.common.ImageSaveService;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.memo.MemoDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.memo.MemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.Date;
import java.util.*;

@Service("memoServiceImpl")
public class MemoServiceImpl implements MemoService {

    //Constructor

    @Autowired
    public MemoServiceImpl(@Qualifier("memoDao") MemoDao memoDao) {
        this.memoDao = memoDao;
    }

    //Field
    private final MemoDao memoDao;

    @Value(value = "#{memo['pageSize']}")
    private int pageSize;

    //new memo defaults
    @Value(value = "#{memo['newMemoTitle']}")
    String newMemoTitle;
    @Value(value = "#{memo['newMemoContents']}")
    String newMemoContents;
    @Value(value = "#{memo['newMemoColor']}")
    String newMemoColor;

    @Autowired
    ImageSaveService imageSaveService;


    //Method
    @Override
    public Memo addMemo(Memo memo) {

        //썸머노트 내부의 html 문자를 빼낸다.
        String html = memo.getMemoContents();
        //이미지를 저장하고, html 내부의 이미지 경로를 변경한다.
        try {
            String userId = memo.getMemoAuthor();
            String subSystem = "memo";
            html = imageSaveService.saveImage(html, userId, subSystem);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        //경로가 변경된 html을 memo에 넣는다.
        memo.setMemoContents(html);
        
        //DB에 메모를 추가한다.
        int affectedRows = 0;
        try {
            affectedRows = memoDao.addMemo(memo);
            if (affectedRows == 1) {
                //삽입된 메모의 Author 로서의 접근권한을 DB에 추가한다.
                MemoAccess memoAccess = new MemoAccess(memo.getMemoNo(), memo.getMemoAuthor(), true);
                int isSuccess2 = memoDao.addMemoAccess(memoAccess);
                if (isSuccess2 == 1) {
                    //끝까지 완전 성공시 추가된 메모의 상태를 get 해서 리턴한다.
                    int addedMemoNo = memo.getMemoNo();
                    System.out.println("추가된 메모의 번호는 " + addedMemoNo);
                    return memoDao.getMemo(addedMemoNo);
                } else {
                    throw new Exception("메모의 접근권한이 추가되지 않았습니다.");
                }
            } else {
                throw new Exception("메모가 추가되지 않았습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<MemoDoc> getMemoList(String userId, Search search) {

        List<Memo> memoList = null;

        //컨트롤러로부터 유저와 검색조건을 받을 것이다. 확실히 User 를 받고 나면, Search 내부의 서치키워드에 User를 넣는 방법으로 변경하자.
        search.setSearchKeyword(userId);
        search.setPageSize(pageSize);

        try {
            //search를 분석해서 {getMemoListByMyMemo, getMemoListBySharedMemo, getMemoListByDeletedMemo} 중 하나를 실행한다.
            switch (search.getSearchCondition()) {
                case "myMemo":
                    System.out.println("myMemo");
                    memoList = memoDao.getMemoListByMyMemo(search);
                    break;
                case "sharedMemo":
                    System.out.println("sharedMemo");
                    memoList = memoDao.getMemoListBySharedMemo(search);
                    break;
                case "deletedMemo":
                    System.out.println("deletedMemo");
                    memoList = memoDao.getMemoListByDeletedMemo(search);
                    break;
                default:
                    throw new Exception("searchCondition이 잘못되었습니다.");
            }

            //디버그문구
//            System.out.println("DB로부터 갖고온 메모들의 정보를 출력합니다.");
//            for(Memo memo : memoList){
//                System.out.println(memo);
//            }
//            System.out.println("DB로부터 갖고온 메모들의 정보의 출력이 끝났습니다.");
            //디버그 끝

            //중복을 제거한 memoDoc들을 만든다.
            MemoDocContainer docCon = new MemoDocContainer();
            for(Memo memo:memoList){
                docCon.putMemo(memo);
            }
            //로직 종료 및 리턴
            Map<String,MemoDoc> targetMap = docCon.getNoDupMap();
            List<MemoDoc> memoDocList = new ArrayList<>(targetMap.values());
            return memoDocList;


        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Memo getMemo(int memoNo) {
        try {
            return memoDao.getMemo(memoNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Memo updateMemo(Memo memo) {

        //썸머노트 내부의 html 문자를 빼낸다.
        String html = memo.getMemoContents();
        //이미지를 저장하고, html 내부의 이미지 경로를 변경한다.
        try {
            String userId = memo.getMemoAuthor();
            String subSystem = "memo";
            html = imageSaveService.saveImage(html, userId, subSystem);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        //경로가 변경된 html을 memo에 넣는다.
        memo.setMemoContents(html);

        //메모 업데이트를 시도한다.
        int isSuccess = 0;
        try {
            isSuccess =  memoDao.updateMemo(memo);
            if (isSuccess == 1) {
                //메모 업데이트가 성공하면 화면단에 변경된 메모의 내용을 보여주기 위해 다시 한번 getMemo를 한다.
                return memoDao.getMemo(memo.getMemoNo());
            } else {
                throw new Exception("메모가 업데이트되지 않았습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateMemoAttach(int attachedCategory, int attachedNo, int memoNo) {
        //bind
        Memo attachingMemo = new Memo();
        attachingMemo.setMemoNo(memoNo);
        switch (attachedCategory) {
            case 0:
                //tripPlan
                attachingMemo.setAttachedTripPlanNo(attachedNo);
                break;
            case 1:
                //review
                attachingMemo.setAttachedReviewNo(attachedNo);
                break;
            case 2:
                //chatRoom
                attachingMemo.setAttachedChatRoomNo(attachedNo);
                break;
            default:
                System.out.println("메모를 탈착합니다.");
        }

        //컨트롤러로부터 memo의 정보를 받는다.
        try {
            //attach 만 바꾼다.
            memoDao.updateMemoAttach(attachingMemo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public Memo deleteMemo(Memo memo){
        //컨트롤러로부터 memoNo와 delDate를 받는다.
        int isSuccess = 0;
        int memoNo = memo.getMemoNo();
        Date delDate = memo.getMemoDelDate();
        //memoNo를 받아서 memo의 del_date 를 업데이트한다.
        try{
            if (delDate == null) {
                System.out.println("delDate is null");
                //받은 memo의 delDate 가 null이라면, 처음 삭제되는 녀석이다. del 를 실행시켜서 delDate를 오늘로 한다.
                isSuccess = memoDao.deleteMemo(memoNo);
                return memoDao.getMemo(memoNo);
            } else {
                System.out.println("delDate is not null");
                //받은 memo의 delDate 가 null이 아니라면, 삭제대기중이었던 녀석이다. remove 를 실행시켜 아예 지워버린다.
                isSuccess = memoDao.removeMemo(memoNo);
                return null;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;

    }
    @Override
    public Memo restoreMemo(Memo memo){
        //컨트롤러로부터 memoNo와 delDate를 받는다.
        int isSuccess = 0;
        int memoNo = memo.getMemoNo();
        //memoNo를 받아서 memo의 del_date 를 업데이트한다.
        try{
            isSuccess = memoDao.restoreMemo(memoNo);
            if (isSuccess == 1) {
                //메모 업데이트가 성공하면 화면단에 변경된 메모의 내용을 보여주기 위해 다시 한번 getMemo를 한다.
                return memoDao.getMemo(memoNo);
            } else {
                throw new Exception("메모가 복구되지 않았습니다.");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int addMemoAccess(String memoShareUser, int memoNo){
        int isSuccess = 0;
        //유저와 넘버를 받는다.
        //일단 그 유저의 이름으로 공유되어있는 문서가 있는지 먼저 찾는다.
        try{
            List<MemoAccess> accessList = memoDao.getMemoAccessListByMemoNo(memoNo);
            for (MemoAccess memoAccess : accessList) {
                if (memoAccess.getMemoAccessUser().equals(memoShareUser)) {
                    throw new Exception("이미 공유된 유저에게 메모를 다시 공유하고자 하고 있습니다.");
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        try {
            MemoAccess memoAccess = new MemoAccess(memoNo, memoShareUser, false);
            isSuccess = memoDao.addMemoAccess(memoAccess);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1;
    }

    @Override
    public List<MemoAccess> getMemoSharerList(int memoNo){
        try{
            List<MemoAccess> memoAccessList = memoDao.getMemoAccessListByMemoNo(memoNo);
            return memoAccessList;
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int deleteMemoAccess(String memoShareUser, int memoNo){
        int isSuccess = 0;
        try {
            MemoAccess memoAccess = new MemoAccess(memoNo, memoShareUser, false);
            isSuccess = memoDao.deleteMemoAccess(memoAccess);

            if(isSuccess!=1){
                throw new Exception("메모 공유자 삭제에 실패하였습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return isSuccess;
        }
        return isSuccess;
    }



}


