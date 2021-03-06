package com.zblog.biz;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zblog.biz.aop.IndexManager;
import com.zblog.core.WebConstants;
import com.zblog.core.dal.constants.PostConstants;
import com.zblog.core.dal.entity.Channel;
import com.zblog.core.dal.entity.Post;
import com.zblog.core.dal.entity.Tag;
import com.zblog.core.dal.entity.Upload;
import com.zblog.core.dal.entity.User;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.core.plugin.TreeUtils;
import com.zblog.core.util.CollectionUtils;
import com.zblog.core.util.JsoupUtils;
import com.zblog.service.ChannelService;
import com.zblog.service.OptionsService;
import com.zblog.service.PostService;
import com.zblog.service.TagService;
import com.zblog.service.UploadService;
import com.zblog.service.UserService;
import com.zblog.service.vo.PageVO;
import com.zblog.service.vo.PostVO;

@Component
public class PostManager{
  @Autowired
  private PostService postService;
  @Autowired
  private UploadService uploadService;
  @Autowired
  private OptionsService optionService;
  @Autowired
  private IndexManager postIndexManager;
  @Autowired
  private TagService tagService;
  @Autowired
  private ChannelService channelService;
  @Autowired
  private UserService userService;

  public PostVO loadReadById(Integer postId){
    PostVO pvo = postService.loadById(postId);
    if(pvo == null)
      return null;

    if(PostConstants.TYPE_POST.equals(pvo.getType())){
      Channel channel = channelService.loadById(pvo.getChannelId());
      pvo.setChannel(channel);
      pvo.setTags(tagService.listTagsByPost(postId));
    }
    User user = userService.loadById(pvo.getCreator());
    pvo.setUser(user);

    return pvo;
  }

  /**
   * 插入文章，同时更新上传文件的postId
   * 
   * @param post
   * @param tags
   */
  @Transactional
  public void insertPost(Post post, List<Tag> tags){
    postService.insert(post);
    /* 查找当前html中所有图片链接 */
    List<String> imgs = extractImagepath(JsoupUtils.getImagesOrLinks(post.getContent()));
    if(!CollectionUtils.isEmpty(imgs)){
      uploadService.updatePostId(post.getId(), imgs);
    }
    List<Tag> tagList = new ArrayList<>();
    for(Tag tag:tags){
      tag.setPostId(post.getId());
      tagList.add(tag);
    }
    if(PostConstants.TYPE_POST.equals(post.getType()) && !CollectionUtils.isEmpty(tagList)){
      tagService.insertBatch(tagList);
    }
  }

  /**
   * 更新文章,先重置以前文件对应的附件的postId,再更新文章对应的postId
   * 
   * @param post
   * @param tags
   * @return 更新文章影响记录数
   */
  @Transactional
  public boolean updatePost(Post post, List<Tag> tags){
    return updatePost(post, tags, false);
  }

  @Transactional
  public boolean updatePost(Post post, List<Tag> tags, boolean fast){
    if(!fast){
      uploadService.setNullPostId(post.getId());
      List<String> imgs = extractImagepath(JsoupUtils.getImagesOrLinks(post.getContent()));
      if(!CollectionUtils.isEmpty(imgs)){
        uploadService.updatePostId(post.getId(), imgs);
      }
    }

    int affect = postService.update(post);

    if(PostConstants.TYPE_POST.equals(post.getType()) && !CollectionUtils.isEmpty(tags)){
      tagService.deleteByPostId(post.getId());
      tagService.insertBatch(tags);
    }

    return affect != 0;
  }

  /**
   * 删除文章,同时删除文章对应的上传记录,及其文件
   * 
   * @param postId
   * @param postType
   *          post类型(文章or页面),注：此参数为给aop使用
   */
  @Transactional
  public void removePost(Integer postId, String postType){
    List<Upload> list = uploadService.listByPostId(postId);
    uploadService.deleteByPostId(postId);
    postService.deleteById(postId);

    for(Upload upload : list){
      File file = new File(WebConstants.APPLICATION_PATH, upload.getPath());
      file.delete();
    }
  }

  public PageModel<PostVO> listPost(int pageIndex, int pageSize){
    return pageId2pageVo(postService.listPost(pageIndex, pageSize));
  }

  public PageModel<PostVO> listPage(int pageIndex, int pageSize){
    return pageId2pageVo(postService.listPage(pageIndex, pageSize));
  }

  public PageModel<PostVO> listByTag(String tagName, int pageIndex, int pageSize){
    return pageId2pageVo(postService.listByTag(tagName, pageIndex, pageSize));
  }

  public PageModel<PostVO> listByChannel(Channel channel, int pageIndex, int pageSize){
    return pageId2pageVo(postService.listByChannel(channel, pageIndex, pageSize));
  }

  public PageModel<PostVO> listByMonth(Date yearMonth, int pageIndex, int pageSize){
    return pageId2pageVo(postService.listByMonth(yearMonth, pageIndex, pageSize));
  }

  public List<PostVO> listBySitemap(){
    List<Integer> postIds = postService.listBySitemap();
    List<PostVO> content = new ArrayList<>(postIds.size());
    for(Integer id : postIds){
      PostVO pvo = postService.loadById(id);
      content.add(pvo);
    }
    return content;
  }

  /**
   *
   * @param nums
   * @param creator   null则查询所有
   * @return
   */
  public List<PostVO> listRecent(int nums, Integer creator){
    List<Integer> list = postService.listRecent(nums, creator);
    List<PostVO> result = new ArrayList<>(list.size());
    for(Integer id : list){
      result.add(loadReadById(id));
    }

    return result;
  }

  private PageModel<PostVO> pageId2pageVo(PageModel<String> postIdPage){
    PageModel<PostVO> result = new PageModel<>(postIdPage.getPageIndex(), postIdPage.getPageSize());
    result.setTotalCount(postIdPage.getTotalCount());
    List<PostVO> content = new ArrayList<>(postIdPage.getContent().size());
    for(String id : postIdPage.getContent()){
      content.add(loadReadById( Integer.valueOf(id)));
    }
    result.setContent(content);
    return result;
  }

  public Collection<PageVO> listPageAsTree(){
    List<PageVO> list = postService.listPage(false);
    TreeUtils.rebuildTree(list);

    return list;
  }

  public PageModel<PostVO> search(String word, int pageIndex){
    PageModel<MapContainer> page = postIndexManager.search(word, pageIndex);
    PageModel<PostVO> result = new PageModel<PostVO>(page.getPageIndex(), page.getPageSize());
    result.setTotalCount(page.getTotalCount());
    result.insertQuery("word", word);
    List<PostVO> content = new ArrayList<>(page.getContent().size());
    /* 填充其他属性，更好的做法是：搜索结果只包含对象id，详细资料到数据库查询(缓存) */
    for(MapContainer mc : page.getContent()){
      PostVO all = loadReadById( Integer.valueOf(mc.getAsString("id")));
      PostVO copy = new PostVO();
      // 此处需要copy，否则会影响缓存内容
      BeanUtils.copyProperties(all, copy, new String[]{ "title", "description" });
      copy.setTitle(mc.getAsString("title"));
      copy.setDescription(mc.getAsString("description"));

      content.add(copy);
    }
    result.setContent(content);

    return result;
  }

  /**
   * 去掉图片中src地址的http域名前缀
   * 
   * @param imgs
   * @return
   */
  private static List<String> extractImagepath(List<String> imgs){
    List<String> imgpaths = new ArrayList<>(imgs.size());
    String domain = WebConstants.getDomain();
    for(String imgUrl : imgs){
      if(imgUrl.startsWith(domain)){
        imgpaths.add(imgUrl.substring(domain.length()));
      }
    }

    return imgpaths;
  }

}
