package com.bit.motrip.common;

import com.bit.motrip.service.cron.CronService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {

    //constructor

    public Scheduler(CronService cronService) {
        this.cronService = cronService;
    }

    //field

    private final CronService cronService;

    //method

    //@Scheduled(cron = "0 15 10 15 * ?") // 매월 15일 오전 10시 15분에 실행
    //@Scheduled(cron = "0 15 10 15 * ?", zone = "Asia/Seoul")
//    @Scheduled(cron = "0 0 0 * * ?", zone = "Asia/Seoul")
    @Scheduled(cron = "0 */1 * * * *", zone = "Asia/Seoul")//1분마다 실행
    public void sec5work() throws Exception {

        cronService.cronDel("memo", "memo", "memo_del_date", "1");

        cronService.cronDel("tripPlan", "trip_plan", "trip_plan_del_date", "1");
    }
}
