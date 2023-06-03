package com.bit.motrip.restcontroller.ReviewRestController;

import com.bit.motrip.common.Search;

import com.bit.motrip.domain.Review;
import com.bit.motrip.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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


}
