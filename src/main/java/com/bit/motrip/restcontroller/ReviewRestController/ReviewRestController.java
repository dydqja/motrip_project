package com.bit.motrip.restcontroller.ReviewRestController;

import com.bit.motrip.common.Search;

import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    public ReviewRestController() {
        System.out.println(this.getClass());
    }

    @Value("c6ffa2721e097b8c38f9548c63f6e31a")
    private String kakaoApiKey;

    @GetMapping("reviewLikes") // 여행후기 추천하기
    public int reviewLikes(@RequestParam("reviewNo") int reviewNo, HttpSession session) throws Exception {
        System.out.println("GET : reviewLikes()");

        User dbUser = (User) session.getAttribute("user");

        if(dbUser == null){ // 로그인 되어있지 않다면 비회원으로 간주
            return 0;
        } else { // 로그인 되어있다면 중복체크를 하기위해 확인 후 추천수를 올린다.
            Map<String, Object> reviewLikes = new HashMap<>();
            reviewLikes.put("reviewNo", reviewNo);
            reviewLikes.put("user", dbUser);
            return reviewService.reviewLikes(reviewLikes);
        }
    }


    @RequestMapping( value="getReviewCount", method= RequestMethod.POST  )
    public int getListCount() throws Exception{
        int count = reviewService.reviewCount();

        return count;
    }

    @PostMapping(value = "fileUpload")
    public ResponseEntity<?> fileUpload(@RequestParam("file") MultipartFile file) throws Exception {
        System.out.println("/review/fileUpload : POST");

        System.out.println("client에서 넘어온 file 값은 => : " + file);
        String fileName = reviewService.fileUpload(file);

        System.out.println("ServiceImpl에서 리턴한 fileName => : " + fileName);

        return ResponseEntity.ok().body("/imagePath/" + fileName);
    }

}
