package com.bit.motrip.serviceimpl.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.memo.MemoDao;
import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAccess;
import com.bit.motrip.service.memo.MemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;
@Service("memoServiceImpl")
public class MemoServiceImpl implements MemoService {

    //Constructor
    @Autowired
    public MemoServiceImpl(@Qualifier("memoDao") MemoDao memoDao) {
        this.memoDao = memoDao;
    }

    //Field
    private MemoDao memoDao;



    //Method
    @Override
    public Memo addMemo(String memoAuthor, Memo memo) {
        //컨트롤러로부터 메모를 받을 것이다.
        //author 에 대한 정보는 컨트롤러에서 Session으로부터 user를 추출해서 받아야 한다. 잊지않고 넣기위해 author를 따로 받는다.
        memo.setMemoAuthor(memoAuthor);

        //DB에 메모를 추가한다.
        int affectedRows = 0;
        try {
            affectedRows = memoDao.addMemo(memo);
            if (affectedRows == 1) {
                //DB에 삽입된 메모의 memo_user_access 추가한다.
                MemoAccess memoAccess = new MemoAccess(memo.getMemoNo(), memo.getMemoAuthor(), true);
                int isSuccess2 = memoDao.addMemoAccess(memoAccess);
                if (isSuccess2 == 1) {

                } else {
                    throw new Exception("메모의 접근권한이 추가되지 않았습니다.");
                }
            } else {
                throw new Exception("메모가 추가되지 않았습니다.");
            }
            return memo;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Memo> getMemoList(String userId, Search search) {

        //컨트롤러로부터 유저와 검색조건을 받을 것이다.
        search.setSearchKeyword(userId);

        try {
            //search를 분석해서 {getMemoListByMyMemo, getMemoListBySharedMemo, getMemoListByDeletedMemo} 중 하나를 실행한다.
            switch (search.getSearchCondition()) {
                case "myMemo":
                    return memoDao.getMemoListByMyMemo(search);
                case "sharedMemo":
                    return memoDao.getMemoListBySharedMemo(search);
                case "deletedMemo":
                    return memoDao.getMemoListByDeletedMemo(search);
                default:
                    throw new Exception("searchCondition이 잘못되었습니다.");
            }
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
    public int updateMemo(Memo memo) {
        //컨트롤러로부터 memo의 정보를 받는다.
        int isSuccess = 0;
        try {
            memoDao.updateMemo(memo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    @Override
    public void updateMemoAttach(Memo memo) {

        //컨트롤러로부터 memo의 정보를 받는다.
        try {
            //memo를 받는다. 화면단에서 memoNo를 포함한 모든 메모의 정보를 줘야한다.
            memoDao.updateMemo(memo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public int deleteMemo(Memo memo){
        //컨트롤러로부터 memoNo와 delDate를 받는다.
        int isSuccess = 0;
        int memoNo = memo.getMemoNo();
        Date delDate = memo.getMemoDelDate();
        //memoNo를 받아서 memo의 del_date 를 업데이트한다.
        try{
            //받은 memo의 delDate 가 null이라면, 처음 삭제되는 녀석이다. del 를 실행시켜서 delDate를 오늘로 한다.
            //받은 memo의 delDate 가 null이 아니라면, 삭제대기중이었던 녀석이다. remove 를 실행시켜 아예 지워버린다.
            if (delDate == null) {
                isSuccess = memoDao.deleteMemo(memoNo);
            } else {
                isSuccess = memoDao.removeMemo(memoNo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return isSuccess;

    }
    @Override
    public int restoreMemo(Memo memo){
        //컨트롤러로부터 memoNo와 delDate를 받는다.
        int isSuccess = 0;
        int memoNo = memo.getMemoNo();
        //memoNo를 받아서 memo의 del_date 를 업데이트한다.
        try{
            isSuccess = memoDao.restoreMemo(memoNo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return isSuccess;
    }

    @Override
    public int addMemoAccess(String memoShareUser, int memoNo){
        int isSuccess = 0;
        try {
            MemoAccess memoAccess = new MemoAccess(memoNo, memoShareUser, false);
            isSuccess = memoDao.addMemoAccess(memoAccess);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    @Override
    public List<MemoAccess> getMemoSharerList(int memoNo){
        try{
            return memoDao.getMemoAccessListByMemoNo(memoNo);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int deleteMemoAccess(String memoShareUser, int memoNo){
        int isSuccess = 0;
        return isSuccess;
    }

}


