package com.bit.motrip.common;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {
//constructor

    public Scheduler() {
    }

    //@Scheduled(cron = "0 15 10 15 * ?") // 매월 15일 오전 10시 15분에 실행
    //@Scheduled(cron = "0 15 10 15 * ?", zone = "Asia/Seoul")
    @Scheduled(cron = "0 0 0 * * ?", zone = "Asia/Seoul")
    public void removeMemo() {
        System.out.println("스케줄러 실행");
    }
}
