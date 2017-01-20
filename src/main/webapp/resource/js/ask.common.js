if(typeof com=="undefined"){
  var ask={};
}

//增加命名空间  使用方法：ask.register('bbb.ccc','admin.zhou');
ask.register =function(){
  var result={},temp;
  for(var i=0;i<arguments.length;i++){
	 temp=arguments[i].split(".");
	 result=window[temp[0]]=window[temp[0]] || {};
	 for(var j=0;j<temp.slice(1).length;j++){
	   result=result[temp[j+1]]=result[temp[j+1]] || {};
	  }
   }
  
  return result;
}

ask.getDomainLink=function(path){
  return window.location.protocol+"//"+window.location.host+"/"+path;
}

/**
 * 生成CSRF Token  并保存cookie中
 * @param path
 * @returns {string}
 */
ask.newCsrf=function(path){
  var csrfValue = (Math.random()+"").substring(2);
  /* 此处token值可以放在cookie中 */
  /*根据设备 调用不同的cookie*/
/*  if(isMobile){
    //移动调用zepto.cookie.min.js的生成cookie方法
    $.fn.cookie("x-csrf-token", csrfValue, {path:"/"+path});
  }else{
  }*/
  //移动调用jquery.cookie.js的生成cookie方法
  $.cookie("x-csrf-token", csrfValue, {path:"/"+path});


   /* $.cookie("x-csrf-token", csrfValue, {path:"/"+path});
    $.fn.cookie("x-csrf-token", csrfValue, {path:"/"+path});*/


  return csrfValue;
}

/*form表单封装成json */
$.fn.form2json = function() {
  var o = {};
  var a = this.serializeArray();
  $.each(a, function() {
    if (o[this.name]) {
      if (!o[this.name].push) {
        o[this.name] = [o[this.name]];
      }
      o[this.name].push(this.value || '');
    } else {
      o[this.name] = this.value || '';
    }
  });
  return o;
};

$(document).on('ajaxSend',function(event,xhr,options){
  var url=options.url;
  var path =url.split("/")[3];
  if(!/^(GET|HEAD|OPTIONS|TRACE)$/.test(options.type)){
    xhr.setRequestHeader("CSRFToken", ask.newCsrf(path));
  }
  // 禁用按钮防止重复提交
  /*var oEvent = oEvent ? oEvent : window.event;
  var oElem = oEvent.toElement ? oEvent.toElement : oEvent.relatedTarget; // 此做法是为了兼容FF浏览器
  console.log(oElem);
  $(oElem).attr("disabled",true);*/
});
/*$(document).on('ajaxBeforeSend', function(event, xhr, settings){
  var url=settings.url;
  var path =url.split("/")[3];
  if(!/^(GET|HEAD|OPTIONS|TRACE)$/.test(settings.type)){
    xhr.setRequestHeader("CSRFToken", ask.newCsrf(path));
  }
});*/

$(document).on('ajaxComplete', function(event, xhr, settings){
  // 解除禁用按钮
  /*var oEvent = oEvent ? oEvent : window.event;
  var oElem = oEvent.toElement ? oEvent.toElement : oEvent.relatedTarget; // 此做法是为了兼容FF浏览器
  $(oElem).removeAttr("disabled");*/
 });


$(function(){
  $("form").each(function(index){
    var csrfValue= ask.newCsrf("app");
    var csrfInput=$(this).find(":input[name='CSRFToken']");
    if(csrfInput.length>0){
      csrfInput.val(csrfValue);
    }else{
      $(this).append("<input type='hidden' name='CSRFToken' value='"+csrfValue+"' />");
    }
  });


  getCookie = function(name){
    var cookieValue = null;
    if(document.cookie && document.cookie != ''){
      var cookies = document.cookie.split('; ');
      for(var i = 0; i < cookies.length; i++){
        var cookie = jQuery.trim(cookies[i]);
        var index = cookie.indexOf("=");
        if(cookie.substring(0, name.length + 1) == (name + '=')){
          cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
          if(cookieValue.charAt(0) == '"')
            cookieValue = cookieValue.substring(1, cookieValue.length - 1);
          break;
        }
      }
    }
    return cookieValue;
  }

});

