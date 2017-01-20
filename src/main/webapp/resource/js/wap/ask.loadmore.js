/**
 * Created by huazhi on 2016/9/30.
 */


ask.register("ask.answer");
/*回答列表加载更多*/
ask.answer.more=function(){
    var _moreBtn = $('.load-more');
    var questionId = _moreBtn.data("id");
    var page = _moreBtn.attr("page");
    $.ajax({
        type:"POST",
        url:ask.getDomainLink("answer/more"),
        data : {"questionId": questionId,"page": page},
        dataType:"json",
        success:function(data){
            var _answerVOPage=data.page;
            var _answerContentHtml="";
            var count=0;
            $(_answerVOPage.content).each(function(){
                var _answerVO=this;

                var _createTime = new Date();
                _createTime.getDate(_answerVO.createTime);
                _createTime=_createTime.pattern("yyyy-MM-dd hh:mm");

                _answerContentHtml +="<div class='ans-list clear'>" +
                "<div class='con-left'><span class='ora'>答</span></div>" +
                "<div class='con-right'>" +
                "<p class='ans-user clear'><a href='#'>"+_answerVO.user.platformUserName+"</a><span>"+_createTime+"</span></p>" +
                "<p class='ans-co'><a class='answer-c' href='#'>"+_answerVO.answerContent+"</a><a class='agree clear' href='#'><span class='up'></span><span  class='up-count'>"+_answerVO.approvalCount+"</span></a> </p>" +
                "</div> " +
                "</div>"
                count++;
            })
            $(".ans-wrap").append(_answerContentHtml);
            _moreBtn.attr("page",_answerVOPage.pageIndex+1);
            if(Math.ceil(_answerVOPage.pageIndex)==Math.ceil(_answerVOPage.totalCount/_answerVOPage.pageSize)){
                _moreBtn.html("已全部加载完").removeAttr("onclick");

            }
        }
    });
}


/*搜索结果列表加载更多*/
$("#search-more").live('click',function(){
    var _thisMore =  $(this).find("p");
    if(_thisMore.html() =='没有更多数据'){
        return ;
    }
    _thisMore.html("<img src='/resource/img/loading.gif'>");
        var  page = $("#page").val();
        if(page == "" ){
            page =1;
        }
        var page1= parseInt(page)+1;
        var questionTitle1 = $("input[name='questionTitle']").val();
        $.ajax({
            type : "POST",
            url:ask.getDomainLink("question/questionSearchListMore"),
            dataType : "json",
            data : {
                "questionTitle":questionTitle1,
                "page":page
            },
            async: false,
            success : function(data){
                $("#page").val(data.pageIndex);
                var _appstr="";
                $(data.page.content).each(function(){
                    var _this =this;
                    _appstr+="<div class='list'><p class='list-top'><a href='/question/"+ _this.questionId+"' >"+ _this.questionTitle+"</a></p>";
                    _appstr+="<p class='list-bottom'><span>"+_this.answerCount+"个</span><span>回答</span>";
                    _appstr+="<span> 浏览</span><span>";
                    if(typeof (this.viewCount) !="undefined"){
                        _appstr+=_this.viewCount;
                    } else {
                        _appstr+=0;
                    }
                    _appstr+="</span>";
                    _appstr+="<a href='/question/"+ _this.questionId+"'>查看回答<span></span></a></p>	</div>";
                });
                $(".Load").before(_appstr);
                if(data.page.content.length<9){
                    _thisMore.html("没有更多数据");
                } else {
                    $("#page").val(page1);
                    _thisMore.html( "加载更多");
                }
            }
        });

});


/*首页 加载更多*/
$('#index-more').live('click',function(){
    var _thisMore =  $(this).find("p");
    if(_thisMore.html() =='没有更多数据'){
        return ;
    }
    _thisMore.html("<img src='/resource/img/loading.gif'>");
        var  page = $("#page").val();
        if(page == ""  || typeof(page) == "undefined"){
            page =1;
        }
        var page1= parseInt(page)+1;
        var  listType = $("input[name='listType']").val();
        $.ajax({
            type : "POST",
            url:ask.getDomainLink("question/questionIndexListMore"),
            dataType : "json",
            data : {
                "listType":listType,
                "page":page1
            },
            async: false,
            success : function(data){
                $("#page").val(data.pageIndex);
                var _appstr="";
                $(data.page.content).each(function(){
                    var _this =this;
                    _appstr+="<li class='clear'><div class='con-right'><div class='title-wrap clear'> <div class='con-left1'><span>问</span></div>";
                    _appstr+="<a href='/question/"+ _this.questionId+"' class='user-ask'>"+ _this.questionTitle+"</a>";
                    _appstr+="<div class='collect'>";
                    var isCollection= false;
                    $(this.questionCollectionList).each(function(o){
                            if(o.questionId = this.questionId){
                                isCollection = true;
                             return;
                            }
                    })

                    if(isCollection ==true){
                        _appstr+="<span class='ect' >已收藏</span>";
                    } else {
                        _appstr+="<span class='coll' >收藏</span>";
                    }
                    _appstr+="<input type='hidden' value='"+ _this.questionId+"'></div> </div>";

                    _appstr+="<div class='co-wrap clea'> <div class='con-left2'><span>答</span></div>"
                    _appstr+="<div class='new-wrap'><a " ;
                    if(_this.user &&_this.user.userId !=null){
                        _appstr+= "href='/user/"+_this.user.userId+"'";
                    }
                    _appstr+= " class='user-answer'>";
                    if(_this.user &&  typeof(_this.user.platformUserName) !='undefined') {
                        _appstr+=_this.user.platformUserName;
                    }
                    _appstr+="</a><p class='answer-co'>";
                    var content ="";
                    if(this.answerVoPage.content.length>0){
                        content =    this.answerVoPage.content[0].answerContent;
                        if((typeof (content) !='undefined') &&(content.length>35)){
                            _appstr+="<a class='answer-c'> "+ content.substring(0,35)+"...</a><a class='read-all'  href='/question/"+ _this.questionId+"'>查看全部</a>";
                            _appstr+="<a class='answer-c' style='display: none'>   "+content+"</a>";
                        }else {
                            _appstr+="<a class='answer-c'> ";
                            if(typeof(content) !='undefined') {
                                _appstr+=content;
                            }
                            _appstr+="</a>";
                        }

                    }
                    _appstr+="</p></div> </div></div></li>";
                });
                $(".Load").before(_appstr);
                if(data.page.content.length<9){
                    _thisMore.html("没有更多数据");
                } else {
                    $("#page").val(page1);
                    _thisMore.html( "加载更多");
                }
            }
        });
});

/*我的问答 加载更多*/
$("#user-quedtion-more").live('click',function(){

    var _thisMore =  $(this);
    if(_thisMore.html() =='没有更多数据'){
        return ;
    }
    _thisMore.html("<img src='/resource/img/loading.gif'>");
        var  page =$("input[name='page']").val();
        if(page == "" ){
            page =1;
        }
        var page1= parseInt(page)+1;
        var  type =$("input[name='type']").val();
        var userId = $("input[name='userId']").val();
        var url ="user/myQuestionMore/"+type;
        $.ajax({
            type : "POST",
            url:ask.getDomainLink(url),
            dataType : "json",
            data : {
                "type":type,
                "page":page1
            },
            async: false,
            success : function(data){
                $("input[name='page']").val(data.pageIndex);
                var _appstr="";
                $(data.page.content).each(function(){
                    var _this =this;
                    if(type  !='message') {
                        _appstr +="<li class='clear'>"
                        +"<p ><a class='ques3'  href='/question/"+_this.questionId+"'>"+_this.questionTitle+"</a></p>"
                        +"<p class='ques4'><span>"+_this.createTime+"</span>";
                        if(type =='ask' || type =='collection') {
                            _appstr +="<span>"+_this.answerCount+"个回答</span><span>";
                            if(typeof(_this.viewCount)  != "undefined"){
                                _appstr +=this.viewCount;
                            } else {
                                _appstr +=0;
                            }
                            _appstr +="个浏览</span>";
                        }
                        _appstr +="</p></li>";
                    } else {
                        _appstr+="<li>"
                        _appstr+="<p class='ques5'><span class='horn-user'>";
                        if(_this.flag ==3){
                            $(_this.userList).each(function(i,o){
                                if(_this.userList.length== (i+1)) {
                                    _appstr+="<a href='/user/"+ o.userId  +"' >"+ o.userName+"</a>";
                                } else {
                                    _appstr+="<a href='/user/"+ o.userId  +"' >"+ o.userName+",</a>";
                                }
                            })
                        } else {
                            _appstr+="<a href='/user/"+_this.user.userId+"'>"+_this.user.platformUserName+"</a>";
                        }
                        _appstr+="</span><span class='horn-com'>";
                        if(_this.flag ==1){
                            _appstr+="回答了你的问题";
                        } else if(_this.flag ==2) {
                            _appstr+="向你请教了问题";
                        } else if(_this.flag ==3) {
                            _appstr+="赞了你对问题";
                        }
                        _appstr+="</span>"
                        +"<span class='horn-que'><a href='/question/"+_this.questionId+"'>"+_this.questionTitle+"</a></span>";
                        if(_this.flag =='collection'){
                            _appstr+="<span class='horn-agr'>的回答 。</span>";

                        }
                        _appstr+="</p>"
                        _appstr+="<p class='ques6 clear'><span class='time-b'>";
                        if(typeof (this.createTime) !="undefined") {
                            _appstr += this.createTime;
                        }
                        _appstr+="</span></p></li>";
                    }
                });
                $(".Load").before(_appstr);
                if(data.page.content.length<10){
                    _thisMore.html("没有更多数据");
                } else {
                    $("#page").val(page1);
                    _thisMore.html( "加载更多");
                }
            }
        });
});



