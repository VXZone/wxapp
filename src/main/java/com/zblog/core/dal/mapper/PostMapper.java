package com.zblog.core.dal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zblog.core.dal.entity.Post;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.service.vo.PageVO;
import com.zblog.service.vo.PostVO;

@SuppressWarnings("unchecked")
public interface PostMapper extends BaseMapper{

  @Override
  public PostVO loadById(Integer postId);

  /**
   * 获取制定post的下一篇
   * 
   * @param postId
   * @return
   */
  Post getPrevPost(Integer postId);

  /**
   * 获取指定post的上一篇
   * 
   * @param postId
   * @return
   */
  Post getNextPost(Integer postId);

  /**
   * 获取页面(只包含ID和title)
   * 
   * @param onlyParent
   * @return
   */
  List<PageVO> listPage(boolean onlyParent);

  /**
   * 列出文章归档
   * 
   * @return
   */
  List<MapContainer> listArchive();

  int addViewCount(@Param("postId") Integer postId, @Param("count") int count);

  int addCommentCount(@Param("commentid") Integer commentid, @Param("count") int count);

  /**
   * 获取最近发表文章
   * 
   * @return 文章id
   */
  List<Integer> listRecent(@Param("nums") int nums, @Param("creator") Integer creator);

  List<String> listByMonth(PageModel<String> model);

  List<String> listByChannel(PageModel<String> model);

  List<String> listByTag(PageModel<String> model);

  void updateChannel(@Param("oldChannelIds") List<Integer> oldChannelIds, @Param("newChannelId") Integer newChannelId);

}
