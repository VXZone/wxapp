ask.register("ask.upload");

/*
ask.upload.uploader=WebUploader.create({
  pick:{
	id: '#picker',
	innerHTML: '点击选择文件'
  },
  dnd: '#uploader .upload-list',
  paste: document.body,
  accept:{
	title: '图片文件',
	extensions: 'gif,jpg,jpeg,bmp,png',
	mimeTypes: 'image*/
/*'
  },
  swf:'../../webuploader-0.1.5/js/Uploader.swf',
  disableGlobalDnd: true,
  chunked: true,
  server: '.',
  fileVal: 'file',
  fileNumLimit: 300,
  fileSizeLimit: 5 * 1024 * 1024,    // 200 M
  fileSingleSizeLimit: 1 * 1024 * 1024    // 50 M
});

ask.upload.upload=function(){
  ask.upload.uploader.upload();
}

ask.upload.fileCount=0;
ask.upload.fileSize=0;
ask.upload.addFile=function(file){
  var progress="<div class='progress progress-striped' style='display:none;'>" +
  		"<div class='progress-bar progress-bar-success'></div></div>";
  var uploadItem=$("<div id='"+file.id+"' class='upload-item'>"
      +"<img src='../../resource/img/type/document.png' /><span class='upload-item-name'>"
	  +file.name+"</span>"+progress+"<a href='#'>删除</a></div>");
  uploadItem.find("a").click(function(){
	 ask.upload.fileCount--;
	 ask.upload.fileSize-=file.size;
	 ask.upload.uploader.removeFile(file);
  });
  
  $("#uploader .upload-list").append(uploadItem);
  ask.upload.showInfo();
};

ask.upload.removeFile=function(file){
  $("#"+file.id).remove();
  if(ask.upload.fileCount==0){
	$("#status-bar").hide();
	$("#uploader .placeholder").show();
  }
};

//添加随传csrf参数
ask.upload.uploader.onUploadBeforeSend=function(block, data){
  data.CSRFToken=ask.newCsrf();
};

ask.upload.uploader.onFileQueued=function(file){
  ask.upload.fileCount++;
  ask.upload.fileSize+=file.size;
  ask.upload.addFile(file);
  //添加“添加文件”的按钮
  ask.upload.uploader.addButton({
     id: "#append-picker",
     innerHTML: '继续添加'
  });
  
  $("#uploader .placeholder").hide();
  $("#status-bar").show();
};

ask.upload.uploader.onFileDequeued=function(file){
  ask.upload.removeFile(file);
};

ask.upload.uploader.onUploadStart=function(file){
   $('#'+file.id).find(".progress").show();
};

ask.upload.uploader.onUploadProgress=function(file, percentage){
  var item = $('#'+file.id);
  item.find('.progress-bar').css( 'width', percentage * 100 + '%' );
  if(percentage==1) item.find("a").off().text("成功");
};

ask.upload.uploader.onUploadError=function(file,reason){
  var item = $('#'+file.id);
  item.find('.progress-bar').removeClass("progress-bar-success").addClass("progress-bar-warning");
  item.find("a").off().text("失败");
};

ask.upload.showInfo=function(){
   $("#status-bar .info").html('选中' + ask.upload.fileCount + '张图片，共' +
	 WebUploader.formatSize(ask.upload.fileSize) + '。');
};*/


jQuery(function() {
  var $ = jQuery,
      $list = $('#fileList'),
  // 优化retina, 在retina下这个值是2
      ratio = window.devicePixelRatio || 1,

  // 缩略图大小
      thumbnailWidth = 100 * ratio,
      thumbnailHeight = 100 * ratio,

  // Web Uploader实例
      uploader;

  // 初始化Web Uploader
  uploader = WebUploader.create({

    // 自动上传。
    auto: true,

    // swf文件路径
    swf:'../../webuploader-0.1.5/js/Uploader.swf',

    // 文件接收服务端。
    server: '/question/upload',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker',

    // 只允许选择文件，可选。
    accept: {
      title: 'Images',
      extensions: 'gif,jpg,jpeg,bmp,png',
      mimeTypes: 'image/*'
    },
    fileNumLimit: 300,
    fileSizeLimit: 4 * 1024 * 1024,    // 200 M
    fileSingleSizeLimit: 1 * 1024 * 1024    // 50 M
  });

  if ( !WebUploader.Uploader.support() ) {
    alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
    throw new Error( 'WebUploader does not support the browser you are using.' );
  }

  ask.upload.fileCount=0;
  // 当有文件添加进来的时候
  uploader.on( 'fileQueued', function( file ) {
    if(ask.upload.fileCount<4){
    var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
            '<img>' +
            '<div class="info">' + file.name + '</div>' +
            '</div>'
        ),
        $img = $li.find('img');

    $list.append( $li );

    $deleteBtn = $('<span class="delete-img"></span>').appendTo( $li );
        $input= $("<input  type='hidden' name='picUrl' />").appendTo( $li );

    // 创建缩略图
    uploader.makeThumb( file, function( error, src ) {
      if ( error ) {
        $img.replaceWith('<span>不能预览</span>');
        return;
      }

      $img.attr( 'src', src );

      $li.find("span").click(function(){
        //提示确定删除
        ask.upload.removeFile(file);
      });
    }, thumbnailWidth, thumbnailHeight );
    }else{
      alert("图片限制4张以内");
    }
  });

  // 文件上传过程中创建进度条实时显示。
  uploader.on( 'uploadProgress', function( file, percentage ) {
    var $li = $( '#'+file.id ),
        $percent = $li.find('.progress span');

    // 避免重复创建
    if ( !$percent.length ) {
      $percent = $('<p class="progress"><span></span></p>')
          .appendTo( $li )
          .find('span');
    }

    $percent.css( 'width', percentage * 100 + '%' );
  });

  // 文件上传成功，给item添加成功class, 用样式标记上传成功。
  uploader.on( 'uploadSuccess', function( file,response) {
    $( '#'+file.id ).addClass('upload-state-done');
    console.log(response.filePth);
    if(response.success){
      $( '#'+file.id).find("input").val(response.filePth);
      ask.upload.fileCount++;
    }
    ask.upload.showInfo();
  });

  // 文件上传失败，现实上传出错。
  uploader.on( 'uploadError', function( file ) {
    var $li = $( '#'+file.id ),
        $error = $li.find('div.error');

    // 避免重复创建
    if ( !$error.length ) {
      $error = $('<div class="error"></div>').appendTo( $li );
    }

    $error.text('上传失败');
  });

  // 完成上传完了，成功或者失败，先删除进度条。
  uploader.on( 'uploadComplete', function( file ) {
    $( '#'+file.id ).find('.progress').remove();
  });


  ask.upload.removeFile=function(file){
    $("#"+file.id).remove();
    ask.upload.fileCount--;
    ask.upload.showInfo();
  };


  uploader.on( 'fileDequeued', function(file ) {
    ask.upload.removeFile(file);
  });
  uploader.onFileDequeued = function( file ) {
    fileCount--;
    fileSize -= file.size;

    if ( !fileCount ) {
      setState( 'pedding' );
    }

    removeFile( file );
    updateTotalProgress();

  };

  //添加随传csrf参数
  // 完成上传完了，成功或者失败，先删除进度条。
  uploader.on( 'uploadBeforeSend', function(block, data ) {
    data.CSRFToken=ask.newCsrf("question");
  });

  ask.upload.showInfo=function(){
    $("#uploader i").html('(' + ask.upload.fileCount + '/4)');
  };

});