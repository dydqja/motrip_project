package com.bit.motrip.review;

import com.bit.MotripApplication;
import com.bit.motrip.common.Search;
import com.bit.motrip.dao.review.ReviewDao;
import com.bit.motrip.domain.DailyPlan;
import com.bit.motrip.domain.Review;
import com.bit.motrip.service.review.ReviewService;
import org.apache.ibatis.annotations.Param;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
class ReviewDaoTest {

    @Autowired
    @Qualifier("reviewDao")
    private ReviewDao reviewDao;

    @Value(value = "#{review['reviewPageSize']}")
    private int reviewPageSize;

    @Test
    void addReview() throws Exception {
        Review review = new Review();
        review.setReviewNo(4);
        review.setTripPlanNo(2);
        review.setReviewAuthor("testUser103");
        review.setReviewTitle("송용범의 블랙리스트 추가 이론");
        review.setReviewContents("블랙리스트 잘되어가고 있나요? 플랜하나에는 후기를 여러개 쓸수 있삼요");
        review.setReviewThumbnail("https://example.com/thumbnail.jpg");
        review.setInstaPostLink("https://www.instagram.com/p/Casdw89/");
        review.setReviewPublic(false);
        review.setReviewLikes(4);
        review.setViewCount(2);
        review.setReviewRegDate(new Date());
        review.setReviewDeleted(false);
        review.setReviewDelDate(null);
        reviewDao.addReview(review);

        System.out.println(review);
        System.out.println("~테스트 완료~");
    }
    //@Test
    void getPublicReviewList() throws Exception {
        //검색 조건 설정
        Search search = new Search();
        search.setCurrentPage(0);
        search.setPageSize(reviewPageSize);

        //공개 처리된 후기 목록가져옴
        List<Review> publicReviewList = reviewDao.getPublicReviewList(search);

        //가져온 후기 목록을 출력쓰
        for (Review review : publicReviewList) {
            System.out.println(review);
        }
    }

    //@Test
    void getMyReviewList() throws Exception {
        //검색 조건 설정
        Search search = new Search();
        search.setCurrentPage(0);
        search.setPageSize(reviewPageSize);
        System.out.println(search);

        //내가 작성한 후기 목록가져옴
        List<Review> myReviewList = reviewDao.getMyReviewList("user1",search);

        //가져온 후기 목록을 출력쓰
        for (Review review : myReviewList) {
            System.out.println(review.toString());
        }

    }

    //@Test
    void getReview() throws Exception {
        int reviewNo = 2; // 원하는 후기 번호를 설정
        Review review = reviewDao.getReview(reviewNo);
        System.out.println(review);
    }
    //@Test
    void updateReview() throws Exception {
        // 후기 정보를 가져옴
        int reviewNo = 1; // 수정하고자 하는 후기 번호를 설정합니다.
        Review review = reviewDao.getReview(reviewNo);
        System.out.println("가져온 후기번호: " + reviewNo);
        System.out.println("수정 전 후기 내용: " + review); // 수정 전 후기 내용 출력

        // 후기 정보를 수정
        review.setReviewTitle("태국에서 380만원 탕진하는 방법");
        review.setReviewContents("한국인의 가슴을 뜨겁게 하는 바로 그것은 조식포함");
        review.setReviewThumbnail("썸네일 썸넫일");
        review.setInstaPostLink("인스타 게시물 11");
        review.setReviewPublic(false);

        // 수정된 후기를 저장
        reviewDao.updateReview(review);
        System.out.println("다음의 내용이 담긴 후기를 저장합니다: " + review);

        // 수정된 후기를 다시 가져와서 확인
        Review updatedReview = reviewDao.getReview(reviewNo);
        System.out.println("수정 후 후기 내용: " + updatedReview); // 수정 후 후기 내용 출력
    }


    //@Test
    void deleteReview() {
        int reviewNo = 1; //삭제할 후기 번호
        reviewDao.deleteReview(reviewNo); //삭제 진행
    }

    //@Test
    void recoverReview() throws Exception {
        int reviewNo = 1;
        reviewDao.recoverReview(reviewNo);

        // 복구된 후기 정보를 가져와서 확인
        Review recoveredReview = reviewDao.getReview(reviewNo);
        System.out.println("복구된 후기 번호: " + reviewNo);
        System.out.println("복구된 후기 내용: " + recoveredReview);
    }

}
