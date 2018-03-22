
$(window).ready(function(){
    $('#context2').hide();

    $('#aa').click(function(){
        $('#context2').hide();
        $('#context1').show();
    })
    $('#bb').click(function(){
        $('#context1').hide();
        $('#context2').show();
    })

    $('.upload-file').on('change', function(){
        $(this).closest('form').submit();
    });

    $('form').submit(function(){
        //return false;
    });

    // $(function() {
    //     /*原理是把本地图片路径："D(盘符):/image/..."转为"http://..."格式路径来进行显示图片*/
    //     $("#change").change(function() {
    //         var $file = $(this);
    //         var objUrl = $file[0].files[0];
    //         //获得一个http格式的url路径:mozilla(firefox)||webkit or chrome
    //         var windowURL = window.URL || window.webkitURL;
    //         //createObjectURL创建一个指向该参数对象(图片)的URL
    //         var dataURL;
    //         dataURL = windowURL.createObjectURL(objUrl);
    //         $(".upload-file").attr("src",dataURL);
    //     });
    // });
    //
    // $('.upload-file').on('change', function(){
    //     alert('hi');
    // });
})


