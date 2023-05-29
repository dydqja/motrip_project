package com.bit.motrip.restcontroller;

import com.bit.motrip.domain.Memo;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/memo/*")
public class MemoRestController {
    @GetMapping("test/{id}")
    public Memo test(@PathVariable("id") String id, HttpSession session)  {
        System.out.println("메모 컨트롤러가 받았음.");
        Memo memo = new Memo();
        memo.setMemoNo(1);
            memo.setMemoContents("즉석에서 만든 메모");
        memo.setMemoTitle("즉석에서 만든 메모제목");
        memo.setMemoAuthor(id);
        return memo;
    }
}
