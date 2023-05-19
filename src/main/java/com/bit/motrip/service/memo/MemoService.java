package com.bit.motrip.service.memo;

import com.bit.motrip.domain.Memo;
import com.bit.motrip.domain.TripPlan;

import java.util.List;

public interface MemoService {
    public List<Memo> getMemoList() throws Exception;
}
