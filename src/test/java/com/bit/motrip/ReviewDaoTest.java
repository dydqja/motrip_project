package com.bit.motrip;

import com.bit.motrip.domain.Review;
import com.bit.motrip.service.review.ReviewService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;
import java.util.List;

@SpringBootTest
class ReviewDaoTest {

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;



    //@Test
    void addReview() {
        Review review = new Review();
        review.setReviewNo(1);
        review.setReviewAuthor("user1");
        review.setReviewTitle("My first review");
        review.setReviewContents("This is my first review.");
        review.setReviewThumbnail("https://example.com/thumbnail.jpg");
        review.setInstaPostLink("https://www.instagram.com/p/Cd23456789/");
        review.setReviewPublic(true);
        review.setReviewLikes(0);
        review.setViewCount(0);
        review.setReviewRegDate(new Date());
        review.setReviewDeleted(false);
        review.setReviewDelDate(null);
    }

    //@Test
    void getReviewList() throws Exception {
        List<Review> reviewList = reviewService.getReviewList();//통하는거 다 확인해
        System.out.println(reviewList.toString());

    }//테스트만 하는 것이기 때문에 void로 돌리고 리턴타입은 당연히 없다

    //@Test
    void getReview() throws Exception {
        int reviewNo = 2; // 원하는 후기 번호를 설정합니다.
        Review review = reviewService.getReview(reviewNo);
        System.out.println(review);
    }


    //@Test
    void updateReview() throws Exception {
        int reviewNo = 1; // 수정하고자 하는 후기 번호를 설정합니다.

        // 후기 정보를 가져옴
        Review review = reviewService.getReview(reviewNo);
        System.out.println("가져온 후기번호 : "+reviewNo);
        // 후기 정보를 수정
        review.setReviewTitle("My updated review");
        review.setReviewContents("Updated review contents");
        review.setReviewThumbnail("Updated thumbnail");
        review.setInstaPostLink("Updated Instagram post link");

        // 수정된 후기를 저장
        reviewService.updateReview(review);
        System.out.println("후기를 저장합니다:" +review);
        // 수정된 후기를 다시 가져와서 확인
        Review updatedReview = reviewService.getReview(reviewNo);
        System.out.println("저장된 후기를 출력스:" +updatedReview);
    }

    //@Test
    void deleteReview() {
        int reviewNo = 1; //삭제할 후기 번호
        reviewService.deleteReview(reviewNo); //삭제 진행
    }

    //@Test
    void recoverReview() {
        int reviewNo = 1; //복구할 후기 번호
        reviewService.recoverReview(reviewNo);//복구 진행
    }
}
