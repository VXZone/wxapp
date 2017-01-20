package com.zblog.core.dal.entity;

import com.zblog.core.dal.constants.PostConstants;

/**
 * 文章/页面,注：post的creator为userId
 * 
 * @author zhou
 * 
 */
public class Post extends BaseEntity{
  private String title;
  /* 摘录,当type为页面该项为null */
  private String description;
  private String content;
  /* 文章类型（post/page等） */
  private String type = PostConstants.TYPE_POST;
  /* 父文章ID，主要用于PAGE,只支持两级 */
  private Integer parent = PostConstants.DEFAULT_PARENT;
  /* 分类ID,主要用于POST */
  private Integer channelId;
  /* 文章状态 */
  private String status = PostConstants.POST_PUBLISH;
  /* 评论状态 */
  private String commentStatus = PostConstants.COMMENT_OPEN;
  /* 评论数 */
  private int commentCount = 0;
  /* 阅读数 */
  private int viewCount = 0;

  public String getTitle(){
    return title;
  }

  public void setTitle(String title){
    this.title = title;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getContent(){
    return content;
  }

  public void setContent(String content){
    this.content = content;
  }

  public String getType(){
    return type;
  }

  public void setType(String type){
    this.type = type;
  }

  public Integer getParent() {
    return parent;
  }

  public void setParent(Integer parent) {
    this.parent = parent;
  }

  public Integer getChannelId() {
    return channelId;
  }

  public void setChannelId(Integer channelId) {
    this.channelId = channelId;
  }

  public String getStatus(){
    return status;
  }

  public void setStatus(String status){
    this.status = status;
  }

  public String getCommentStatus(){
    return commentStatus;
  }

  public void setCommentStatus(String commentStatus){
    this.commentStatus = commentStatus;
  }

  public int getCommentCount(){
    return commentCount;
  }

  public void setCommentCount(int commentCount){
    this.commentCount = commentCount;
  }

  public int getViewCount(){
    return viewCount;
  }

  public void setViewCount(int viewCount){
    this.viewCount = viewCount;
  }

}
