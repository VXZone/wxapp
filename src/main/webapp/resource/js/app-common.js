$(function(){$(".body-container").append('<div class="fixed_box"><a class="look_telephone"><div class="telephone_pop"></div></a><a class="to_top"></a></div>');var wWidth=$(window).width();var wHeight=$(window).height();var imgLeft=0;var scrollTop=0;if($(this).scrollTop()>200){$(".fixed_box .to_top").show()}else{$(".fixed_box .to_top").hide()}
$(window).scroll(function(){scrollTop=$(this).scrollTop()
if($(this).scrollTop()>200){$(".fixed_box .to_top").fadeIn()}else{$(".fixed_box .to_top").fadeOut()}})
$(".fixed_box").css("bottom","120px")
if(wWidth<980){imgLeft=(wWidth- 980)- 140;}else{imgLeft=(wWidth- 980)/ 2 - 140}
$(".fixed_box").css("right",imgLeft);$(window).resize(function(){wWidth=$(window).width();wHeight=$(window).height();if(wWidth<980){imgLeft=(wWidth- 980)- 140;}else{imgLeft=(wWidth- 980)/ 2 - 140;}
$(".fixed_box").css("bottom","120px")
$(".fixed_box").css("right",imgLeft);})
$(".look_telephone").hover(function(){$(".telephone_pop").stop(true,true).fadeIn();},function(){$(".telephone_pop").stop(true,true).fadeOut();})
$(".to_top").click(function(){$('body,html').animate({scrollTop:0},200);})})
function setImgWH(obj){if(obj.width>obj.height){$(obj).css('height','100%');}else{$(obj).css('width','100%');}}
$(function(){var H_ture=$(".switchbox .content").height();var flag=true;if(H_ture>36){$(".switchbox .content").css("height","36px")
$(".slideBtn a").click(function(){if(flag){$(".switchbox .content").animate({"height":H_ture})
$(this).addClass("active")}else{$(".switchbox .content").animate({"height":"36px"})
$(this).removeClass("active")}
flag=!flag;})}
$(".switchbox .content a").click(function(){$(".switchbox .content a").removeClass("active")
$(this).addClass("active")})})