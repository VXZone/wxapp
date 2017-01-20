package com.zblog.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zblog.core.dal.constants.PostConstants;
import com.zblog.core.dal.entity.Channel;
import com.zblog.core.dal.entity.Post;
import com.zblog.core.dal.mapper.BaseMapper;
import com.zblog.core.dal.mapper.PostMapper;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.service.vo.PageVO;

@Service
public class PostService extends BaseService{
  @Autowired
  private PostMapper postMapper;

  public Post getNextPost(Integer postId){
    return postMapper.getNextPost(postId);
  }

  public Post getPrevPost(Integer postId){
    return postMapper.getPrevPost(postId);
  }

  /**
   * 更改阅读数
   * 
   * @param postId
   * @param count
   */
  public int addViewCount(Integer postId, int count){
    return postMapper.addViewCount(postId, count);
  }

  /**
   * 更改评论数
   * 
   * @param commentid
   * @param count
   */
  public int addCommentCount(Integer commentid, int count){
    return postMapper.addCommentCount(commentid, count);
  }

  /**
   * 获取指定作者的最近文件
   * 
   * @param nums
   * @param creator
   *          作者id,当为<code>null</code>或者
   *          <code>PostConstants.POST_CREATOR_ALL</code>时代表所有作者
   * @return
   */
  public List<Integer> listRecent(int nums, Integer creator){
    return postMapper.listRecent(nums, creator);
  }

  public PageModel<String> listPost(int pageIndex, int pageSize){
    PageModel<String> page = new PageModel<>(pageIndex, pageSize);
    page.insertQuery("type", PostConstants.TYPE_POST);
    super.list(page);
    /* 由于分页标签会根据query产生,这里删除掉无用query,下同 */
    page.removeQuery("type");
    return page;
  }

  public PageModel<String> listByChannel(Channel channel, int pageIndex, int pageSize){
    PageModel<String> page = new PageModel<>(pageIndex, pageSize);
    page.insertQuery("channel", channel);
    List<String> content = postMapper.listByChannel(page);
    page.setContent(content);
    page.removeQuery("channel");

    return page;
  }

  public PageModel<String> listByTag(String tagName, int pageIndex, int pageSize){
    PageModel<String> page = new PageModel<>(pageIndex, pageSize);
    page.insertQuery("tagName", tagName);
    List<String> content = postMapper.listByTag(page);
    page.setContent(content);
    page.removeQuery("tagName");

    return page;
  }

  public PageModel<String> listByMonth(Date yearMonth, int pageIndex, int pageSize){
    PageModel<String> page = new PageModel<>(pageIndex, pageSize);
    page.insertQuery("yearMonth", yearMonth);
    List<String> content = postMapper.listByMonth(page);
    page.setContent(content);
    page.removeQuery("yearMonth");

    return page;
  }

  public List<Integer> listBySitemap(){
    PageModel<Integer> page = new PageModel<>(1, -1);
    page.insertQuery("type", PostConstants.TYPE_POST);
    super.list(page);

    return page.getContent();
  }

  public PageModel<String> listPage(int pageIndex, int pageSize){
    PageModel<String> page = new PageModel<>(pageIndex, pageSize);
    page.insertQuery("type", PostConstants.TYPE_PAGE);
    super.list(page);
    page.removeQuery("type");
    return page;
  }

  /**
   * 获取所有页面(只包含ID和title)
   * 
   * @param onlyParent
   *          是否只取父类页面
   * @return
   */
  public List<PageVO> listPage(boolean onlyParent){
    return postMapper.listPage(onlyParent);
  }

  /**
   * 列出文章归档
   * 
   * @return
   */
  public List<MapContainer> listArchive(){
    return postMapper.listArchive();
  }

  public void updateChannel(List<Integer> oldChannelIds, Integer newChannelId){
    postMapper.updateChannel(oldChannelIds, newChannelId);
  }

  @Override
  protected BaseMapper getMapper(){
    return postMapper;
  }

}
