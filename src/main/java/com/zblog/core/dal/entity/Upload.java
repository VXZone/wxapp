package com.zblog.core.dal.entity;

/**
 * 文章、页面的元数据,如文章包含的图片等待
 *
 * @author zhou
 *
 */
public class Upload extends BaseEntity{
  /* 对应文章id */
  private Integer postId;
  /* 图片名称 */
  private String name;
  /* 图片访问路径 */
  private String path;

  public Integer getPostId() {
    return postId;
  }

  public void setPostId(Integer postId) {
    this.postId = postId;
  }

  public String getName(){
    return name;
  }

  public void setName(String name){
    this.name = name;
  }

  public String getPath(){
    return path;
  }

  public void setPath(String path){
    this.path = path;
  }

}
