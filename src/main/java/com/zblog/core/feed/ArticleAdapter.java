package com.zblog.core.feed;

import java.util.Date;

import com.zblog.core.feed.Channel.Article;
import com.zblog.service.vo.PostVO;

public class ArticleAdapter implements Article{
  private PostVO post;

  public ArticleAdapter(PostVO post){
    this.post = post;
  }

  @Override
  public String getTitle(){
    return post.getTitle();
  }

  @Override
  public String getLink(){
    return "/posts/" + post.getId();
  }

  @Override
  public String getChannel(){
    return post.getChannel().getName();
  }

  @Override
  public String getAuthor(){
    return post.getUser().getUsername();
  }

  @Override
  public String getDescription(){
    return post.getDescription();
  }
  
  @Override
  public String getContent(){
    return post.getContent();
  }

  @Override
  public Date getPubDate(){
    return post.getCreateTime();
  }

  @Override
  public String getGuid(){
    return getLink();
  }

}
