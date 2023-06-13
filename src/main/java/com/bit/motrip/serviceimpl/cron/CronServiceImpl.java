package com.bit.motrip.serviceimpl.cron;

import com.bit.motrip.dao.cron.CronDao;
import com.bit.motrip.service.cron.CronService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("cronServiceImpl")
public class CronServiceImpl implements CronService {

    //constructor

    public CronServiceImpl() {
    }
    @Autowired
    public CronServiceImpl(CronDao cronDao) {
        this.cronDao = cronDao;
    }

    //field
    private CronDao cronDao;

    //method
    @Override
    public void cronDel(String subSystem, String targetTable, String targetColumn, String gracePeriodMinute) throws Exception {

        //지워질 대상의 리스트를 가져온다.
//        List<Integer> targetList = cronDao.getDeleteTargetList(targetTable, targetColumn, gracePeriodDays);

        //지워질 대상의 리스트를 확인해서 이미지를 지운다.


        //진짜 삭제명령을 내린다.
        int result = cronDao.cronDel(targetTable, targetColumn, gracePeriodMinute);
    }
}
