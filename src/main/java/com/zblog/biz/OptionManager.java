package com.zblog.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.zblog.core.dal.constants.OptionConstants;
import com.zblog.core.dal.constants.PostConstants;
import com.zblog.core.util.NumberUtils;
import com.zblog.core.util.StringUtils;
import com.zblog.service.OptionsService;
import com.zblog.web.backend.form.GeneralOption;
import com.zblog.web.backend.form.MailOption;
import com.zblog.web.backend.form.PostOption;

@Component
public class OptionManager{
  @Autowired
  private OptionsService optionService;

  /**
   * 更新网站基础设置，同时更新WebConstants中变量
   * 
   * @param form
   */
  @Transactional
  public void updateGeneralOption(GeneralOption form){
    optionService.updateOptionValue(OptionConstants.TITLE, form.getTitle());
    optionService.updateOptionValue(OptionConstants.SUBTITLE, form.getSubtitle());
    optionService.updateOptionValue(OptionConstants.DESCRIPTION, form.getDescription());
    optionService.updateOptionValue(OptionConstants.KEYWORDS, form.getKeywords());
  }

  @Transactional
  public void updatePostOption(PostOption form){
    optionService.updateOptionValue(OptionConstants.MAXSHOW, form.getMaxshow() + "");
    optionService.updateOptionValue(OptionConstants.ALLOW_COMMENT, form.isAllowComment() + "");
    optionService.updateOptionValue(OptionConstants.DEFAULT_CHANNEL_ID, form.getDefaultChannel());
  }

  @Transactional
  public void updateMailOption(MailOption form){
    optionService.updateOptionValue("mail_host", form.getHost());
    optionService.updateOptionValue("mail_port", form.getPort() + "");
    optionService.updateOptionValue("mail_username", form.getUsername());
    optionService.updateOptionValue("mail_password", form.getPassword());
  }

  /**
   * 获取下一篇文章ID,使用select for update 保证id自增
   * 
   * @return
   */
  @Transactional
  public String getNextPostId(){
    String currentid = optionService.getOptionValueForUpdate(OptionConstants.POSTID);
    int id = NumberUtils.toInteger(currentid, PostConstants.INIT_POST_ID);
    id++;
    optionService.updateOptionValue(OptionConstants.POSTID, id + "");

    return id + "";
  }

  /**
   * 从数据库中获取站点通用设置,不存在时返回null
   * 
   * @return
   */
  public GeneralOption getGeneralOption(){
    GeneralOption form = new GeneralOption();
    form.setTitle(optionService.getOptionValue(OptionConstants.TITLE));
    if(!StringUtils.isBlank(form.getTitle())){
      form.setSubtitle(optionService.getOptionValue(OptionConstants.SUBTITLE));
      form.setDescription(optionService.getOptionValue(OptionConstants.DESCRIPTION));
      form.setKeywords(optionService.getOptionValue(OptionConstants.KEYWORDS));
      form.setWeburl(optionService.getOptionValue("weburl"));
    }else{
      form = null;
    }

    return form;
  }

  public PostOption getPostOption(){
    PostOption option = new PostOption();
    option.setMaxshow(NumberUtils.toInteger(optionService.getOptionValue(OptionConstants.MAXSHOW), 10));
    option.setAllowComment(Boolean.parseBoolean(optionService.getOptionValue(OptionConstants.ALLOW_COMMENT)));
    option.setDefaultChannel(optionService.getOptionValue(OptionConstants.DEFAULT_CHANNEL_ID));

    return option;
  }

  public MailOption getMailOption(){
    MailOption option = new MailOption();
    option.setHost(optionService.getOptionValue("mail_host"));
    if(!StringUtils.isBlank(option.getHost())){
      option.setPort(Integer.parseInt(optionService.getOptionValue("mail_port")));
      option.setUsername(optionService.getOptionValue("mail_username"));
      option.setPassword(optionService.getOptionValue("mail_password"));
    }else{
      option = null;
    }

    return option;
  }

}
