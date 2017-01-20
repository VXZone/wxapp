package com.zblog.web.front.controller;

import com.zblog.biz.AppManager;
import com.zblog.core.WebConstants;
import com.zblog.core.dal.entity.App;
import com.zblog.core.dal.entity.Category;
import com.zblog.core.dal.entity.User;
import com.zblog.core.plugin.MapContainer;
import com.zblog.core.plugin.PageModel;
import com.zblog.core.util.JsoupUtils;
import com.zblog.core.util.StringUtils;
import com.zblog.core.util.UploadUtil;
import com.zblog.service.AppService;
import com.zblog.service.CategoryService;
import com.zblog.service.vo.AppVO;
import com.zblog.web.backend.form.validator.AppFormValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.HtmlUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by huazhi on 2017/1/12.
 */
@Controller
@RequestMapping("/app")
public class AppController {
    @Autowired
    private AppService appService;
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AppManager appManager;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(@RequestParam(value = "page", defaultValue = "1") int page, String word, Model model){
        MapContainer map= new MapContainer();
        PageModel<AppVO> appPageModel =  appService.listByCondition(map ,page, 10);
        List<Category> categoryList = categoryService.list();
        model.addAttribute("page",appPageModel);
        model.addAttribute("categoryList",categoryList);
        return "app";
    }

    @RequestMapping(value = "/{appId}", method = RequestMethod.GET)
    public String app(@PathVariable("appId") Integer appId, Model model){
        AppVO appVO = appService.getAppVOById(appId);

        /*浏览数+1*/
        appVO.setViewCount(appVO.getViewCount()+1);
        appService.update(appVO);

        model.addAttribute("appVO",appVO);
        return "app/index";
    }

    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String apply(Integer id, Model model){
       /* if(id!=null){
            model.addAttribute("post", appService.loadById(id));
        }*/

        model.addAttribute("categoryList", categoryService.list());
        return "add";
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
     public MapContainer add(App app,
                             @RequestParam(value = "iconFile" ,required = false) MultipartFile iconfile,
                             @RequestParam(value = "qrcodeFile" ,required = false) MultipartFile qrcodeFile,
                             @RequestParam(value = "picFile" ,required = false)List<MultipartFile> picFileList){
        MapContainer result = AppFormValidator.validateInsert(app);
        if(!result.isEmpty()){
            return result.put("success", false);
        }

        String icon = UploadUtil.upload(iconfile);
        String qrcode = UploadUtil.upload(qrcodeFile);
        List<String> picPaths = new ArrayList<>();
        for(MultipartFile pic:picFileList){
            String picPath = UploadUtil.upload(qrcodeFile);
            picPaths.add(picPath);
        }
        String pics = StringUtils.join(picPaths,",");

        app.setIcon(icon);
        app.setQrcode(qrcode);
        app.setPics(pics);

        /*String tags = StringUtils.join(tagList,",");
        app.setTags(tags);*/

        /* 使用jsoup来对问题标题和内容进行过滤 */
        String name = HtmlUtils.htmlUnescape(app.getName());
        app.setName(JsoupUtils.simpleText(name));
        String description = HtmlUtils.htmlUnescape(app.getDescription());
        app.setDescription(JsoupUtils.simpleText(description));

        appService.insert(app);
        result.put("success", true);
        result.put("msg", "提交成功，请耐心等待审核");
        return result;
    }


}
