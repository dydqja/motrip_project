package com.bit.motrip.service.cron;

public interface CronService {
    void cronDel(String subSystem, String targetTable, String targetColumn, String gracePeriodMinute) throws Exception;
}
