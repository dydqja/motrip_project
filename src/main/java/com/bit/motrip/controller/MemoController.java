package com.bit.motrip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/memo/*")
public class MemoController {

        @RequestMapping("memoList")
        public String memoList() {
            System.out.println("GET : memoList()");
            return "memo/getMemoList.tiles";
        }
}
