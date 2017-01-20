package com.zblog.core.dal.mapper;

import com.zblog.core.dal.entity.App;
import com.zblog.core.plugin.PageModel;
import com.zblog.service.vo.AppVO;

import java.util.HashMap;
import java.util.List;

public interface AppMapper extends BaseMapper{

    AppVO getAppVOById(Integer appId);

    List<AppVO> listByCondition(PageModel<AppVO> model);
}
