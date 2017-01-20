package com.zblog.web.backend.controller;

import java.util.Date;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.zblog.biz.OptionManager;
import com.zblog.biz.PostManager;
import com.zblog.core.dal.constants.PostConstants;
import com.zblog.core.dal.entity.Post;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.core.util.JsoupUtils;
import com.zblog.core.util.PostTagHelper;
import com.zblog.core.util.StringUtils;
import com.zblog.service.ChannelService;
import com.zblog.service.PostService;
import com.zblog.service.vo.PostVO;
import com.zblog.web.backend.form.validator.PostFormValidator;
import com.zblog.web.support.WebContextFactory;

@Controller(value = "adminPostController")
@RequestMapping("/backend/posts")
@RequiresRoles(value = { "admin", "editor" }, logical = Logical.OR)
public class PostController{
  @Autowired
  private PostManager postManager;
  @Autowired
  private OptionManager optionManager;
  @Autowired
  private ChannelService channelService;
  @Autowired
  private PostService postService;

  @RequestMapping(method = RequestMethod.GET)
  public String index(@RequestParam(value = "page", defaultValue = "1") int page, Model model){
    PageModel<PostVO> pageModel = postManager.listPost(page, 15);
    model.addAttribute("page", pageModel);
    model.addAttribute("channels", channelService.list());
    return "backend/post/list";
  }

  @ResponseBody
  @RequestMapping(method = RequestMethod.POST)
  public Object insert(Post post, String tags){
    MapContainer form = PostFormValidator.validatePublish(post);
    if(!form.isEmpty()){
      return form.put("success", false);
    }

    //post.setId(optionManager.getNextPostId());
    post.setCreator(WebContextFactory.get().getUser().getId());
    post.setCreateTime(new Date());
    post.setUpdateTime(post.getCreateTime());

    /* 由于加入xss的过滤,html内容都被转义了,这里需要unescape */
    String content = HtmlUtils.htmlUnescape(post.getContent());
    post.setContent(JsoupUtils.filter(content));
    String cleanTxt = JsoupUtils.plainText(content);
    post.setDescription(cleanTxt.length() > PostConstants.EXCERPT_LENGTH ? cleanTxt.substring(0,
            PostConstants.EXCERPT_LENGTH) : cleanTxt);

    postManager.insertPost(post, PostTagHelper.from(post, tags, post.getCreator()));
    return new MapContainer("success", true);
  }

  @ResponseBody
  @RequestMapping(method = RequestMethod.PUT)
  public Object update(Post post, String tags){
    MapContainer form = PostFormValidator.validateUpdate(post);
    if(!form.isEmpty()){
      return form.put("success", false);
    }

    /* 由于加入xss的过滤,html内容都被转义了,这里需要unescape */
    String content = HtmlUtils.htmlUnescape(post.getContent());
    post.setContent(JsoupUtils.filter(content));
    String cleanTxt = JsoupUtils.plainText(content);
    post.setDescription(cleanTxt.length() > PostConstants.EXCERPT_LENGTH ? cleanTxt.substring(0,
            PostConstants.EXCERPT_LENGTH) : cleanTxt);

    post.setType(PostConstants.TYPE_POST);
    post.setUpdateTime(new Date());
    postManager.updatePost(post, PostTagHelper.from(post, tags, WebContextFactory.get().getUser().getId()));
    return new MapContainer("success", true);
  }

  @ResponseBody
  @RequestMapping(value = "/fast", method = RequestMethod.PUT)
  public Object fast(Post post, String tags){
    MapContainer form = PostFormValidator.validateFastUpdate(post);
    if(!form.isEmpty()){
      return form.put("success", false);
    }

    Post old = postService.loadById(post.getId());
    if(old == null){
      return form.put("success", false).put("msg", "非法请求");
    }

    post.setContent(old.getContent());
    post.setDescription(old.getDescription());

    post.setType(PostConstants.TYPE_POST);
    post.setUpdateTime(new Date());
    postManager.updatePost(post, PostTagHelper.from(post, tags, WebContextFactory.get().getUser().getId()), true);
    return new MapContainer("success", true);
  }

  @ResponseBody
  @RequestMapping(value = "/{postId}", method = RequestMethod.DELETE)
  public Object remove(@PathVariable("postId") Integer postId){
    postManager.removePost(postId, PostConstants.TYPE_POST);
    return new MapContainer("success", true);
  }

  @RequestMapping(value = "/edit", method = RequestMethod.GET)
  public String edit(Integer pid, Model model){
    if(pid!=null){
      model.addAttribute("post", postManager.loadReadById(pid));
    }

    model.addAttribute("channels", channelService.list());
    return "backend/post/edit";
  }

}
