package com.zblog.web.backend.form;

/**
 * 文章设置表单
 * 
 * @author zhou
 * 
 */
public class PostOption{
  /**
   * 博客页面至多显示数
   */
  private int maxshow;
  /**
   * 允许文章评论
   */
  private boolean allowComment;
  /**
   * 默认文章分类
   */
  private String defaultChannel;

  public int getMaxshow(){
    return maxshow;
  }

  public void setMaxshow(int maxshow){
    this.maxshow = maxshow;
  }

  public boolean isAllowComment(){
    return allowComment;
  }

  public void setAllowComment(boolean allowComment){
    this.allowComment= allowComment;
  }

  public String getDefaultChannel(){
    return defaultChannel;
  }

  public void setDefaultChannel(String defaultChannel){
    this.defaultChannel = defaultChannel;
  }

}
