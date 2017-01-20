/**
 * Created by huazhi on 2016/9/9.
 */

ask.register("ask.answer");

/*回答*/
ask.answer.add=function(){
    var answerContent = $.trim($("#answerContent").val());
    if(answerContent==""){
        $("#answerContent").focus();
        alert("回答内容不能为空");
        return ;
    }else if(answerContent.length>1000){
        alert("回答内容字符数限制1000个字符");
        return ;
    }

    var questionId = $.trim($("input[name='questionId']").val());

    var picUrlArr = new Array();
    $("input[name='picUrl']").each(function(){
        picUrlArr.push($(this).val());
    });
    if(picUrlArr.length>4){
        alert("图片张数限制4张以内");
        return ;
    }

    var data={
        questionId : questionId,
        answerContent : answerContent,
        picUrls : picUrlArr.toString().trim()
    };

    $.ajax({
        type:"POST",
        url:ask.getDomainLink("answer"),
        data:data,
        dataType:"json",
        async:false,
        beforeSend: function(){
            $(".submit").val("提交中···");
            $(".submit").attr("disabled",true);
        },
        success:function(data){
            if(data&&data.success){
                location.href = "/question/"+data.questionId;
            }else{
                alert(data.msg);
                if(data&&data.target){
                    window.open(data.target);
                }
            }
        },
        complete: function(){
            $(".submit").val("提交问题");
            $(".submit").removeAttr("disabled")
        }
    });
}







