zblog.register("zblog.page");
$(function(){
  $('#editor-nav a').click(function (e) {
    e.preventDefault();//阻止a链接的跳转行为
    $(this).tab('show');//显示当前选中的链接及关联的content
    zblog.page.editType=$(this).attr("href").substring(8);
  });
  
  if(!document.getElementById("ueditor")) return ;
  
  zblog.page.editType='mk';
  zblog.page.ueditor = UE.getEditor('ueditor',{
    /* 阻止div标签自动转换为p标签 */
    allowDivTransToP: false,
	  autoHeightEnabled: true,
	  autoFloatEnabled: true
  });
  zblog.page.ueditor.ready(function(){
    zblog.page.ueditor.execCommand('serverparam',{'CSRFToken': zblog.newCsrf()});
  });
  
  zblog.page.epiceditor=new EpicEditor({
    basePath: window.location.protocol+"//"+window.location.port+window.location.host+"/resource/epiceditor-0.2.3",
    useNativeFullscreen: false,
    clientSideStorage: false,
    file:{
      defaultContent: $("#editor-txt-tt").val(),
      autoSave: false
    },
    autogrow: {
      minHeight: 400,
      maxHeight: 600
    }
  });
  zblog.page.epiceditor.load();
});

zblog.page.insert=function(){
  var title=$.trim($("#title").val());
  if(title==""){
	 $("#title").focus();
	 return ;
  }
  
  var _getText=function(){
    var result;
    switch(zblog.page.editType){
    case "ue":
      result = zblog.page.ueditor.getContent();
      break;
    case "txt":
      result = $("#editor-txt-tt").val();
      break;
    case "mk":
      result = zblog.page.epiceditor.getElement('previewer').body.innerHTML;
      break;
    default: result="";
    }
    
    return result;
  };

  console.info(_getText());
  var postId=$("#postId").val();
  var data={title : title,
	     content : _getText(),
	     parent : $("#parent").val(),
	     commentStatus : $("input:radio[name=commentStatus]:checked").val()
	   };
  
  if(postId.length>0) data.id=postId;
  
  $.ajax({
    type:postId.length>0?"PUT":"POST",
    url:zblog.getDomainLink("pages"),
    data:data,
    dataType:"json",
    success:function(data){
	    if(data&&data.success){
	       window.location.href=".";
      }else{
    	  alert(data.msg);
      }
     }
  });
}

zblog.page.remove=function(postId){
 $.ajax({
   type:"DELETE",
   url:zblog.getDomainLink("pages/"+postId),
   dataType:"json",
   success:function(data){
	  if(data&&data.success){
	    window.location.reload();
    }else{
      alert(data.msg);
     }
   }
 });
}

zblog.page.edit=function(postId){
  window.location.href=zblog.getDomainLink("pages/edit?pid="+postId);
}