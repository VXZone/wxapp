package com.zblog.core.dal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zblog.core.plugin.MapContainer;
import com.zblog.service.vo.CommentVO;

public interface CommentMapper extends BaseMapper{

  List<CommentVO> listRecent();

  List<MapContainer> listCountByGroupStatus();

  /**
   * 根据postId获取被批准的评论和指定creator的评论
   * 
   * @param postId
   * @param creator
   * @return
   */
  List<CommentVO> listByPost(@Param("postId") Integer postId, @Param("creator") String creator);

  /**
   * 更改comment的状态
   * 
   * @param commentid
   */
  int setStatus(@Param("commentid") Integer commentid, @Param("status") String status);

}
