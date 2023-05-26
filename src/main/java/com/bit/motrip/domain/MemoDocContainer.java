package com.bit.motrip.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MemoDocContainer {

        //constructor
        public MemoDocContainer() {
            this.noDupMap = new HashMap<>();
        }
        //field
        Map<String,MemoDoc> noDupMap;

        //method
        public void putMemo(Memo memo){
            //들어온 문서 안에 들어있는 내용을 분해한다.
            TripPlan innerTripPlan = memo.getAttachedTripPlan();
            Review innerReview = memo.getAttachedReview();
            ChatRoom innerChatRoom = memo.getAttachedChatRoom();
            String key = "";
            if(innerTripPlan!=null){
                key = "tp"+innerTripPlan.getTripPlanNo();
            } else if (innerReview!=null) {
                key = "rv"+innerReview.getReviewNo();
            } else if (innerChatRoom!=null) {
                key = "cr"+innerChatRoom.getChatRoomNo();
            } else {
                key = "no";
            }
            //Map내부의 중복을 체크하고, 있으면 넣고 없으면 만든다.
            if(noDupMap.containsKey(key)){
                //있으면 넣는다.
                System.out.println("있으니 넣겠습니다.");
                MemoDoc theDoc = noDupMap.get(key);
                theDoc.getMemoList().add(memo);
            }else{
                //없으니 만든다.
                System.out.println("없으니 만듭니다.");
                MemoDoc newDoc = new MemoDoc();
                newDoc.setTripPlan(innerTripPlan);
                newDoc.setReview(innerReview);
                newDoc.setChatRoom(innerChatRoom);
                //생성자에 의해서 반드시 메모 리스트가 만들어진다.
                newDoc.getMemoList().add(memo); //그 안에 메모를 넣었다
                noDupMap.put(key,newDoc);
            }
        }
        public Map<String,MemoDoc> getNoDupMap(){
            return this.noDupMap;
        }

    }

