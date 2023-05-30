package com.bit.motrip.restcontroller;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.service.memo.MemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;

@CrossOrigin
@RestController
@RequestMapping("/memo/*")
public class MemoRestController {

    //Constructor wiring
    public MemoRestController(MemoService memoService) {
        this.memoService = memoService;
    }
    //Field
    private final MemoService memoService;

    //Method
    @GetMapping("test/{id}")
    public String test(@PathVariable("id") String id, HttpSession session)  {



        //json 으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String json = "";

        return json;
    }
}
