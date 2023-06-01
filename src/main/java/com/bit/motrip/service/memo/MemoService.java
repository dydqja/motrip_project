package com.bit.motrip.service.memo;

import com.bit.motrip.common.Search;
import com.bit.motrip.domain.*;

import java.util.List;
import java.util.Map;

public interface MemoService {

    //메모 관련

    Memo addMemo(User user) throws Exception;
    ///새로운 메모를 작성하는 기능.

    //유저 객체를 받아서, 그 id를 받는다.
    //그 id의 값을 MemoAuthor로 하는 새로운 빈 메모를 만들어서 DB에 추가한다.

    //메모를 만들면서 동시에 memo_access테이블에도 is_author = true 인 접근권한을 추가해야한다.
    //add이후 add된 Memo를 get해서 return 하는 것으로 화면단에 즉시 출력한다.

    List<MemoDoc> getMemoList(String userId, Search search) throws Exception;
    //세션으로부터 user 를 검출해서 보내주는 것은 컨트롤단에서 하기로 한다.

    //회원이 접근할 수 있는 모든 메모를 조회하는 기능.
    //회원이 설정한 세 가지 조건에 따라 메모 조회
    //1. 내가 소유중인 메모만 보겠다.
    //2. 다른 사람에게서 공유받은 메모도 보겠다.
    //3. 삭제대기 상태인 메모만 보겠다.

    //이후 메모가 부착된 문서의 썸네일을 출력하기 위해서 아래의 작업을 거쳐야 함.
    //메모의 attached들을 모두 갖고와서, <중복을 제거한> 하나의 부착문서 리스트에 담는다.


    Memo getMemo(int memoNo) throws Exception;
    //메모의 No를 기준으로 메모의 구체적인 정보를 불러오는 기능.
    //수정버튼이나 삭제버튼을 띄울지말지 여부를 화면에서 판단하기 위해서는, Author 를 함께 뽑아올 필요성이 있다.

    Memo updateMemo(Memo memo) throws Exception;
    //메모를 수정하는 기능
    //화면단에서 이미 한번 Author 임을 체크했기 때문에 이 메소드로 들어오는 사람은 반드시 Author 일 것이다.
    //추가적인 권한체크는 후순위로 미룬다.

    //메모 삭제
    Memo deleteMemo(Memo memo) throws Exception;
    //메모를 삭제하는 기능
    //수정과 동일 이유로 권한체크는 후순위

    Memo restoreMemo(Memo memo) throws Exception;


    //메모 공유 관련

    int addMemoAccess(String memoShareUser, int memoNo) throws Exception;
    //메모 접근 권한 부여
    //메모를 공유받는 사람에게 접근권한을 부여하는 기능.
    //메모엑세스에는 메모의 No와, 접근권한을 부여받는 사람의 ID가 들어간다. isAuthor 은 반드시 false이다.
    //isAuthor 가 true인 삽입은 메모를 add할 때 dao에서 자동으로 이루어진다.

    //메모 접근 권한 삭제
    int deleteMemoAccess(String memoShareUser, int memoNo) throws Exception;
    //메모 접근 권한 삭제
    //접근 대상인 메모가 삭제되면 접근권한도 삭제되어야 하는데, 이는 Table의 Cascade 옵션으로 해결했다.
    //따라서 이것은 메모를 공유받고 있는 사람의 권한을 작성자가 말소하는 기능으로 활용된다.

    //메모 접근 권한자 조회
    List<MemoAccess> getMemoSharerList(int memoNo) throws Exception;


    //메모 부착 관련

    void updateMemoAttach(int attachedCategory, int attachedNo, int memoNo) throws Exception;
    //메모를 특정 도메인에 부착/탈착하는 기능이다.
    //내부적으로는 메모 Table 의 attached_trip_plan_no, attached_review_no, attached_chat_room_no를 업데이트하는 기능이다
    //부착시에는 해당 도메인의 No를 받아서, 메모의 attached_XXX_no 에 업데이트한다.
    //탈착시에는 모든 메모의 attached_XXX_no 를 null로 업데이트한다.

}
