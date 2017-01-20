/**
 * 
 */

$(document).ready(function(){

	/*点赞*/
	$(".up").live("click",function(){
		var _this=$(this);
		var answerId = _this.data("aid");
		$.ajax({
			type:"POST",
			url:ask.getDomainLink("reaction/approval"),
			data : {"answerId": answerId},
			dataType:"json",
			async:false,
			beforeSend: function(){
				_this.val("提交中···");
				_this.attr("disabled",true);
			},
			complete: function(){
				_this.val("提交问题");
				_this.removeAttr("disabled")
			},
			success:function(data){
				if(data.success){
					var _countSpan = _this.next();
					_countSpan.html(Number(_countSpan.html())+1);
				}else{
					alert(data.msg);
					if(data&&data.target){
						window.open(data.target);
					}
				}
			}
		});

	})

	/*添加收藏*/
	$(".coll").live('click',function(){
		var _this =$(this);
		var questionId = _this.data("qid");
		var isLogin = true;
		if(isLogin == true){
			$.ajax({
				type:"POST",
				url:ask.getDomainLink("collection"),
				data:{"questionId":questionId},
				dataType:"json",
				async:false,
				beforeSend: function(){
					_this.val("提交中···");
					_this.attr("disabled",true);
				},
				complete: function(){
					_this.val("提交问题");
					_this.removeAttr("disabled")
				},
				success:function(data){
					if(data&&data.success){
						_this.attr("class","ect").html("已收藏");
					}else{
						alert(data.msg);
						if(data&&data.target){
							window.open(data.target);
						}
					}
				}
			})
		}
	});

	/*取消收藏*/
	$(".ect").live('click',function(){
		var _this =$(this);
		var questionId = _this.data("qid");
		var isLogin = true;
		if(isLogin == true){
			$.ajax({
				type:"DELETE",
				url:ask.getDomainLink("collection/"+questionId),
				dataType:"json",
				async:false,
				beforeSend: function(){
					_this.val("提交中···");
					_this.attr("disabled",true);
				},
				complete: function(){
					_this.val("提交问题");
					_this.removeAttr("disabled")
				},
				success:function(data){
					if(data&&data.success){
						_this.attr("class","coll").html("收藏");
					}else{
						alert(data.msg);
						if(data&&data.target){
							window.open(data.target);
						}
					}
				}
			})
		}
	});

});


