package com.zblog.service;

import com.zblog.core.dal.entity.App;
import com.zblog.core.dal.mapper.AppMapper;
import com.zblog.core.dal.mapper.BaseMapper;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.service.vo.AppVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AppService extends BaseService{
  @Autowired
  private AppMapper appMapper;

  public PageModel<App> list(int pageIndex, int pageSize){
    PageModel<App> page = new PageModel<>(pageIndex, pageSize);
    super.list(page);
    return page;
  }
  



  public AppVO getAppVOById(Integer appId) {
   return appMapper.getAppVOById(appId);
  }

  public PageModel<AppVO> listByCondition(MapContainer map, int pageIndex, int pageSize) {
    PageModel<AppVO> result = new PageModel<>(pageIndex, pageSize);
    result.insertQuery("map", map);
    List<AppVO> list =  appMapper.listByCondition(result);
    result.removeQuery("map");
    result.setContent(list);
    return result;
  }


  @Override
  protected BaseMapper getMapper(){
    return appMapper;
  }
}
