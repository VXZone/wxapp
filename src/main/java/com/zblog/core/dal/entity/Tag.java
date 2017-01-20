package com.zblog.core.dal.entity;

public class Tag extends BaseEntity{
  private String name;
  private Integer postId;

  public String getName(){
    return name;
  }

  public void setName(String name){
    this.name = name;
  }

  public Integer getPostId() {
    return postId;
  }

  public void setPostId(Integer postId) {
    this.postId = postId;
  }
}
