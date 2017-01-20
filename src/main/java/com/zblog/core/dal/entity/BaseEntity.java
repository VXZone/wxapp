package com.zblog.core.dal.entity;

import java.util.Date;

public class BaseEntity{
  private Integer id;
  private Integer creator;
  private Date updateTime;
  private Date createTime;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public Date getCreateTime(){
    return createTime;
  }

  public void setCreateTime(Date createTime){
    this.createTime = createTime;
  }

  public Integer getCreator() {
    return creator;
  }

  public void setCreator(Integer creator) {
    this.creator = creator;
  }

  public Date getUpdateTime() {
    return updateTime;
  }

  public void setUpdateTime(Date updateTime) {
    this.updateTime = updateTime;
  }
}
