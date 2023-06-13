package com.bit.motrip.dao.cron;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CronDao {
    int cronDel(String targetTable, String targetColumn, String gracePeriodMinute) throws Exception;

    List<Integer> getDeleteTargetList(String targetTable, String targetColumn, String gracePeriodMinute) throws Exception;
}
