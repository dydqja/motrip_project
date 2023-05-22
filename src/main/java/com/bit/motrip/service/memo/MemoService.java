package com.bit.motrip.service.memo;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.MemoAttachable;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;

import java.util.List;

public interface MemoService {
    //새 메모 작성
    void addMemo() throws Exception;
    //회원이 접근할 수 있는 모든 메모 조회
    //회원이 설정해두었던 두 가지 조건에 따라 메모 조회
    //1. 다른 사람에게서 공유받은 메모도 같이 보겠다.
    //2. 다른 문서에 부착된 메모도 같이 보겠다.
    //3. 삭제대기 상태인 메모만 보겠다.
    List<Memo> getMemoList(User user) throws Exception;

    //특정 메모 조회
    Memo getMemo(int memoNo) throws Exception;

    //메모 수정
    void updateMemo(Memo memo) throws Exception;

    //메모 삭제
    void deleteMemo(int memoNo) throws Exception;

    //메모 접근 권한 부여
    void addMemoAccess() throws Exception;

    //메모 접근 권한 삭제
    void deleteMemoAccess() throws Exception;

    //메모를 도메인에 부착
    void addMemoAttach(MemoAttachable memoAttachable) throws Exception;

    //메모를 도메인에서 분리
    void deleteMemoAttach(MemoAttachable memoAttachable) throws Exception;

}
