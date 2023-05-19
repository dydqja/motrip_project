package com.bit.motrip.dao.review;

import com.bit.motrip.domain.Review;
import org.apache.ibatis.annotations.Mapper;

import javax.xml.stream.events.Comment;
import java.util.List;

@Mapper
public interface ReviewDao {
    //후기 부분 CRUD
    //INSERT C 후기 작성
    public void addReview() throws Exception;

    //SELECT LIST 후기 목록 조회
    public List<Review> getReviewList() throws Exception;

    //SELECT ONE R 특정 후기 조회
    public Review getReview() throws Exception;

    //UPDATE U 후기 수정
    public int updateReview(Review review) throws Exception;

    //DELETE D 후기 삭제
    public int deleteReview(int reviewNo);



    //Comment 댓글 부분 CRD
    //INSERT C 댓글 작성
    public Void addComment()throws Exception;

    //SELECT LIST R 댓글 목록조회
    public List<Comment> getCommentList() throws Exception;

    //SELECT ONE R  특정 댓글 조회  (대댓글 기능 구현시 필요한 메서드)
    public Comment getComment() throws Exception;

    //DELETE D
    public int deleteComment(int commentNo);


}//end of ReviewDao
