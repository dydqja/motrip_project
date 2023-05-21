package com.bit.motrip.serviceimpl.memo;

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
    public MemoServiceImpl() {
    }

    //Field
    @Autowired
    @Qualifier("memoDao")
    private MemoDao memoDao;

    //Methods
    @Override
    public void addMemo() throws Exception {

    }

    @Override
    public List<Memo> getMemoList(User user) throws Exception {
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
    public void addMemoAttach(MemoAttachable memoAttachable) throws Exception {

    }

    @Override
    public void deleteMemoAttach(MemoAttachable memoAttachable) throws Exception {

    }
}
