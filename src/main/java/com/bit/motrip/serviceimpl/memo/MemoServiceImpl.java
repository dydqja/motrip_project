package com.bit.motrip.serviceimpl.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.dao.memo.MemoDao;
import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAttachable;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.memo.MemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("memoServiceImpl")
public class MemoServiceImpl implements MemoService {

    //Constructor

    //Field
    @Autowired
    @Qualifier("memoDao")
    private MemoDao memoDao;

    //Method
    @Override
    public void addMemo(Memo memo) throws Exception {
        //Controller 에서 Memo의 Author 에 User 객체를 넣어줘야 한다.
        memoDao.addMemo(memo);
    }

    @Override
    public List<Memo> getMemoList(User user, Search search) throws Exception {
        String targetId = user.getUserId();
        search.setSearchKeyword(targetId);
        return null;
    }

    @Override
    public Memo getMemo(int memoNo) throws Exception {
        return null;
    }

    @Override
    public void updateMemo(Memo memo) throws Exception {

    }

    @Override
    public void deleteMemo(int memoNo) throws Exception {

    }

    @Override
    public void addMemoAccess() throws Exception {

    }

    @Override
    public void deleteMemoAccess() throws Exception {

    }

    @Override
    public void addMemoAttach(int memoNo, MemoAttachable memoAttachable) throws Exception {

    }

    @Override
    public void deleteMemoAttach(int memoNo, MemoAttachable memoAttachable) throws Exception {

    }

    @Override
    public void updateMemoAttach(int memoNo, MemoAttachable memoAttachable) throws Exception {

    }

    @Override
    public MemoAttachable getMemoAttach(int memoNo) throws Exception {
        return null;
    }
}
