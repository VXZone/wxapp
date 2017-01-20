package com.zblog.service;

import com.zblog.core.dal.entity.Category;
import com.zblog.core.dal.mapper.BaseMapper;
import com.zblog.core.dal.mapper.CategoryMapper;
import com.zblog.core.plugin.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService extends BaseService{
  @Autowired
  private CategoryMapper categoryMapper;

  public PageModel<Category> list(int pageIndex, int pageSize){
    PageModel<Category> page = new PageModel<>(pageIndex, pageSize);
    super.list(page);
    return page;
  }
  

  @Override
  protected BaseMapper getMapper(){
    return categoryMapper;
  }

  public void insertAppCategory(Integer id, int[] categotyIds) {
    categoryMapper.insertAppCategory(id,categotyIds);
  }

}
