/**
 * 
 */
$(function(){
	//我要留学
	$('.want').hover(function(){
		$('.want_main').show();
		$('.want a.want_con').addClass('want_con_esp');
	},function(){
		$('.want_main').hide();
		$('.want a.want_con').removeClass('want_con_esp');
	});

	//search院校种类替换
	$('.wire li').click(function(){
		var text = $(this).text();
		$('.wire span').text(text);
		if($('.wire span').html()=="资讯"){
			$("#searchForm").attr("action","http://www.eduwo.com/search.jspx");
			$("#searchForm input:first").attr("name","q");
			$("#searchForm input:first").attr("placeholder","资讯关键词");
		}else if($('.wire span').html()=="院校"){
			$("#searchForm").attr("action","http://school.eduwo.com/search/searchSchool");
			$("#searchForm input:first").attr("name","keywords");
			$("#searchForm input:first").attr("placeholder","院校关键词");
		}else if($('.wire span').html()=="专业"){
			$("#searchForm").attr("action","http://school.eduwo.com/search/searchSpecialty");
			$("#searchForm input:first").attr("name","keywords");
			$("#searchForm input:first").attr("placeholder","专业关键词");
		}
	})
	
	//search院校种类替换
	$('.wire span').click(function(){
		$('.wire_con').show();
		$('.wire').addClass('wire_esp');
	});
	$('.wire').blur(function(){
		$('.wire_con').hide();
                $('.wire').removeClass('wire_esp');
	});
	$('.wire li').click(function(){
		var text = $(this).text();
		$('.wire span').text(text);
		$('.wire_con').hide();
		$('.wire').removeClass('wire_esp');
	});

	//登录后的状态
	$('.admin_ple').hover(function(){
		$('.admin_ple p').show();
		$(this).find('span').addClass('esp_show');
	},function(){
		$('.admin_ple p').hide(); 
		$(this).find('span').removeClass('esp_show');
	});



	//DIY申请入口
	$("form select").each(function(index){
		$(this).change(function(){
			//点击时清除from下select的error样式
			$(this).removeClass("error");
			//获取何时出国下拉列表
			if(index==0||index==1){
					var applyCountryId = $("#applyCountryId").val();
					var applyEducationId = $("#applyEducationId").val();
					if(applyCountryId!=""&&applyEducationId!=""){
						$.ajax({
							type : "post",
							dataType : "jsonp",
							data : {"applyCountryId": applyCountryId,"applyEducationId" : applyEducationId},
							url : "http://diy.eduwo.com/apply/api/getApplyEducation",
							success: function(data){
								var abroad_grade_option = "<option value=''>何时出国</option>";
								console.log(data[0].data.length);
								if(data[0].code=1){
									for(var i = 0; i < data[0].data.length; i++){
										abroad_grade_option = abroad_grade_option + "<option value='" + data[0].data[i].cnEducationId + "'>" + data[0].data[i].cnEducationName +"</option>"
									}
								}else if(data[0].code=0){
									console.log("error:获取何时出国的下拉框列表失败,data无数据");
								}
								$("#abroadGrade").html(abroad_grade_option);
							},
						    error:function (data) {
								console.log("error:获取何时出国的下拉框列表失败");
						    }
						});
					}
			}	
			
		})
	});

	//图片延迟加载
	/*$("img.lazy").lazyload({
		placeholder : "../img/sys/loading.gif"
		//effect: "fadeIn" //淡出效果

   });*/
	
})

/*DIY申请入口提交校验*/
function VaildDIY(){
	var applyCountryId = $("#applyCountryId").val();
	var applyEducationId = $("#applyEducationId").val();
	var abroadGrade = $("#abroadGrade").val();
	
	if(applyCountryId == ""){
		$("#applyCountryId").addClass("error").Shake(2, 10);
		return false;
	}else if(applyEducationId == ""){
		$("#applyEducationId").addClass("error").Shake(2, 10);
		return false;
	}else if(abroadGrade == ""){
		$("#abroadGrade").addClass("error").Shake(2, 10);
		return false;
	}else{
		return true;
	}

}

/*
 *DIY申请入口提交校验
 *param：shakenum:抖动的次数，shakeDistance：抖动的距离
 */
jQuery.fn.Shake = function (shakenum , shakeDistance) {
	this.each(function () {
		var jSelf = $(this);
		jSelf.css({ position: 'relative' });
		for (var x = 1; x <= shakenum; x++) {
			jSelf.animate({ left: (-shakeDistance) }, 50).animate({ left: shakeDistance }, 50).animate({ left: 0 }, 50);
		}
	});
	return this;
}

	
	
	
	
	
	//******************************登陆状态*************************************
	$.ajax({
	  url:"http://diy.eduwo.com/student/api/isHaveLogin",
	  type: "GET",
	  dataType: "jsonp",
	  success: function (data) {
		 if(data[0].status==0){
			 $("#noLogin").show();
			 $("#haveLogin").hide();
		 }else if(data[0].status==1){
			 $(".admin_ple span").html(data[0].studentName);
			 $("#noLogin").hide();
			 $("#haveLogin").show();
		 }
	  },
	  error:function (data) {
		console.log("error:用户登录状态获取失败");
	  }
	});


	//******************************退出论坛和eduwo*************************************
	function Logout() {
		$.ajax({ 
			  url:"http://diy.eduwo.com/discuz/discuzExit",
			  type: "GET",
			  dataType: "jsonp",
			  success: function (data) {
                          document.write("<div style='display: none;'>"+data[0].content+"</div>");
			  exitEduwo();
			  },
		  error:function (data) {
			console.log("error:退出获取失败");
		  }
		}); 
	}
	

//******************************退出eduwo*************************************
	function exitEduwo(){
		$.ajax({ 
			  url:"http://diy.eduwo.com/student/studentLogout",
			  type: "GET",
			  dataType: "jsonp",
			  success: function (data) {
			  parent.location.reload();
			  },
		  error:function (data) {
			console.log("error:退出获取失败");
		  }
		}); 
	}



	//******************************回答方式切换******************************
	$('.type-nav li').click(function(){
		$('.type-nav li').attr('class','');
		$(this).attr('class','type-show');
		var $i = $(this).index();
		$('.content-nav li').attr('class','');
		$('.content-nav li').eq($i).attr('class','content-show');
	});
