/**
 * Created by huazhi on 2016/9/7.
 */

ask.register("ask.question");

/*提问*/
ask.question.add=function(){
    var questionTitle = $.trim($("input[name='questionTitle']").val());
    if(questionTitle==""){
        $("input[name='questionTitle']").focus();
        return ;
    }else if(questionTitle.length>50){
        alert("问题标题字符数限制50个以内");
        return ;
    }

    var questionContent = $.trim($("#questionContent").val());
    if(questionContent.length>100){
        alert("问题补充说明字符数限制100个以内");
        return ;
    }

    var tagIdArr = new Array();
    $("input[name='tagId']").each(function(){
     tagIdArr.push(parseInt($(this).val()));
     });
    if(tagIdArr.length<=0){
        alert("请选择标签");
        return ;
    }else if(tagIdArr.length>6){
        alert("标签个数限制6个以内");
        return ;
    }

    var picUrlArr = new Array();
    $("input[name='picUrl']").each(function(){
        picUrlArr.push($(this).val());
    });
    if(picUrlArr.length>4){
        alert("图片张数限制4张以内");
        return ;
    }

    var answerUserId = $.trim($("input[name='answerUserId']").val());

    var data={
     questionTitle : questionTitle,
     questionContent : questionContent,
     answerUserId : answerUserId,
     tagIds : tagIdArr.toString().trim(),
     picUrls : picUrlArr.toString().trim()
     };

    /*var data=$("#askForm").form2json();*/
    /*var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    parent.window.askFrame();*/
    $.ajax({
        type:"POST",
        url:ask.getDomainLink("question"),
        data:data,
        dataType:"json",
        async:false,
        beforeSend: function(){
            $(".submit").val("提交中···");
            $(".submit").attr("disabled",true);
        },
        complete: function(){
            $(".submit").val("提交问题");
            $(".submit").removeAttr("disabled")
            /*parent.layer.close(index);*/
        },
        success:function(data){
            if(data&&data.success){
                //跳转问题详情
                window.location.href="/question/"+data.questionId;
                //判断是否layer引用 若是 提问成功则关闭
                if(typeof (parent.layer)!=undefined){
                    parent.location.reload();
                    parent.layer.close(index);
                    parent.layer.msg('提问成功', {time: 20000});
                    /*parent.layer.alert('提问成功', function(){
                        window.opener.location.reload();
                    });*/
                }
            }else{
                alert(data.msg);
                if(data&&data.target){
                    window.open(data.target);
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}

$(function(){

    /*根据标题生成标签*/
    $("input[name='questionTitle']").change(function(){
        var _title = $("input[name='questionTitle']").val().trim();
        if(_title=="") {
            $('.tag-selected span').remove();
            $('.tag-selectable span').remove();
            return;
        }
        $.post(ask.getDomainLink('tag/selectByTitle'), {title:_title}, function(data) {
            $('.tag-selectable span').each(function(){
                $(this).remove();
            });
            var selectedIds=new Array();
            $('.tag-selected span').each(function(){
                selectedIds.push($(this).attr("data-tagId"));
            });

            var tagJson= JSON.parse(data);
            var tagArr= JSON.parse(tagJson.tagArrStr);
            console.log(tagArr);
            for(var i in tagArr){
                if($.inArray(tagArr[i].tagId.toString(), selectedIds)==-1){
                    $('.tag-selectable').append("<span data-tagId="+tagArr[i].tagId+">"+tagArr[i].tagName+"</span>");
                }
            }
        });
    });

    /*取消选择标签*/
    $('.tag-selected span').live('click',function(){
        $(this).find('em').remove();
        $(this).find('input').remove();
        $('.tag-selectable').append($(this));
        if($('.tag-selected span').size()<=0){
            $('.tag-selected i').show();
        }
    });

    /*选择标签*/
    $('.tag-selectable span').live('click',function(){
        var tagId=$(this).attr("data-tagId");
        $(this).append("<em>×</em>");
        $(this).append("<input type='hidden' name='tagId' value="+tagId+" >");
        $(this).remove();
        $('.tag-selected i').hide();
        $('.tag-selected').append($(this));
    });


    $("#questionContent").keydown(function(){
        $(this).val().length;
    });


})
