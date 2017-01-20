zblog.register("zblog.user");

zblog.user.remove=function(userId){
 $.ajax({
   type:"DELETE",
   url:zblog.getDomainLink("users/"+userId),
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

zblog.user.edit=function(userId){
  window.location.href=zblog.getDomainLink("users/edit?uid="+userId);
}