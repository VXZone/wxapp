/**
 * 
 */

$(document).ready(function() {

// 切换标签分类
/*	$('.tagClass li').live('click',function(){
		var tagParentId = $(this).attr("tagParentId");
		window.location.href ='/askTag/tagSortList?tagParentId='+tagParentId;
	})*/

	/*添加/取消关注*/
	$('.add-att').live('click',function(){
		var _this = $(this);
		var tagId = _this.next("input").val();
		if(_this.html()=='+关注'){
			$.ajax({
				type:"POST",
				url:ask.getDomainLink("tag/follow"),
				data : {"tagId": tagId},
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
						_this.html("已关注");
						var  count =  _this.parent().parent().find(".addFollow").html();
						_this.parent().parent().find(".addFollow").html(parseInt(count)+1);
					}else{
						alert(data.msg);
						if(data&&data.target){
							window.open(data.target);
						}
					}
				}
			})
		} else {
			$.ajax({
				type:"POST",
				url:ask.getDomainLink("tag/nofollow"),
				data : {"tagId": tagId},
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
						_this.html("+关注");
						var  count =   _this.parent().parent().find(".addFollow").html();
						_this.parent().parent().find(".addFollow").html(parseInt(count)-1);
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
//点击展开隐藏
$(function(){
var hei = $('.ul-wrap ul').height();
if(hei > 70){
	$('.all-show').css('display','block');
}else{
	$('.all-show').css('display','none');
}
})
$('.all-show').click(function(){

	var more = $(this),
		mareParent = more.prev();
	if(mareParent.hasClass('addM')) {
		more.text('收回');
		mareParent.removeClass('addM');
	} else {
		more.text('点击展开');
		mareParent.addClass('addM');
	}

});
