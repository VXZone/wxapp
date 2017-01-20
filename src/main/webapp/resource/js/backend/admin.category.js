zblog.register("zblog.channel");
$(function(){
  $.ajax({
	 type:"GET",
	 url:zblog.getDomainLink("channels/index"),
	 dataType:"json",
	 success:function(data){
	   if(!data) return ;
	   $('#tree').treeview({data:data,nodeIcon:"glyphicon glyphicon-star-empty"});
	 }
  });
});

zblog.channel.insert=function(){
 var newChannel=$("#newChannel").val();
 if(!newChannel) return ;
  
 var select = $("#tree .node-selected");
 $.ajax({
   type:"POST",
   url:zblog.getDomainLink("channels"),
   dataType:"json",
   data:{parent:select.text(),name:newChannel},
   success:function(msg){
	   if(msg&&msg.success){
	     window.location.reload();
	     zdialog.hide('insert-box');
	   }else{
	      alert(msg.msg); 
		 }
	 }
  });
}

zblog.channel.remove=function(){
  var select = $("#tree .node-selected").text();
  if(!select) return ;
  
  $.ajax({
   type:"DELETE",
   url:zblog.getDomainLink("channels/"+select),
   dataType:"json",
   success:function(msg){
	 if(msg&&msg.success){
	   window.location.reload();
	 }else{
	   alert("删除失败"); 
	  }
	}
  });
}