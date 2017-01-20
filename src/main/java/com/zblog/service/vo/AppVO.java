package com.zblog.service.vo;

import com.zblog.core.dal.entity.*;

import java.util.List;

/**
 * 小程序业务对象
 * 
 * @author qianhao
 *
 */
public class AppVO extends App{
  private User user;
  private Category category;



  public User getUser(){
    return user;
  }

  public void setUser(User user){
    this.user = user;
  }

  public Category getCategory() {
    return category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }


}
