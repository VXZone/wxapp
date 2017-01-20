package com.zblog.biz;

import com.zblog.core.dal.constants.OptionConstants;
import com.zblog.core.dal.entity.App;
import com.zblog.core.dal.entity.Channel;
import com.zblog.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Component
public class AppManager {
    @Autowired
    private AppService appService;

    @Autowired
    private CategoryService categoryService;





}
