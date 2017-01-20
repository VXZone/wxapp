package com.zblog.core.dal.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zblog.core.dal.entity.Upload;

public interface UploadMapper extends BaseMapper{
  
  List<Upload> listByPostId(Integer postId);

  /**
   * 更新上传文件记录对应的文章ID
   * 
   * @param postId
   * @param imgpaths
   * @return
   */
  public int updatePostId(@Param("postId") Integer postId, @Param("imgpaths") List<String> imgpaths);

  /**
   * 将所有postId的记录置空,非删除记录
   * 
   * @param postId
   */
  public void setNullPostId(Integer postId);

  public int deleteByPostId(Integer postId);

}
