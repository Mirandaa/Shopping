<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>注册 - 千寻 - Thousands Find</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="js/kit.js"></script>
    <!--[if IE]>
    <script src="js/ieFix.js"></script>
    <![endif]-->
    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push([ '_setAccount', 'UA-30210234-1' ]);
        _gaq.push([ '_trackPageview' ]);
        (function() {
            var ga = document.createElement('script');
            ga.type = 'text/javascript';
            ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl'
                    : 'http://www')
                + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(ga, s);
        })();
    </script>
    <link rel="stylesheet" href="css/login.css" />
    <!--validator-->
    <script src="js/validator.js"></script>
    <script src="js/autowired.validator.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script language="javascript">
        var code;
        function send_mess(){
            $.post('jsp/sms.jsp', {phoneNum:jQuery.trim($('#phoneNum').val())}, function(msg) {
                code=unescape(msg).substr(unescape(msg).length-8,6);
                /*  alert(code); */
                if(msg.indexOf('提交成功')>=0){
                    RemainTime();
                }
                else
                {
                    alert("请检查手机号");
                }
            });
        };
        var iTime=59;
        var Account;
        function RemainTime(){
            document.getElementById('code_btn').disabled = true;
            var iSecond,sSecond="",sTime="";
            if (iTime >= 0){
                iSecond = parseInt(iTime%60);
                iMinute = parseInt(iTime/60)
                if (iSecond >= 0){
                    if(iMinute>0){
                        sSecond = iMinute + "分" + iSecond + "秒";
                    }else{
                        sSecond = iSecond + "秒";
                    }
                }
                sTime=sSecond;
                if(iTime==0){
                    clearTimeout(Account);
                    sTime='获取手机验证码';
                    iTime = 59;
                    document.getElementById('code_btn').disabled = false;
                }else{
                    Account = setTimeout("RemainTime()",1000);
                    iTime=iTime-1;
                }
            }else{
                sTime='没有倒计时';
            }
            document.getElementById('code_btn').value = sTime;
        }
        function checkCode(form){
            if(form.code.value==""){
                alert("请输入验证码");
                return false;
            }
            else if(form.code.value!=code){
                alert("验证码错误,请重试"+form.code.value+"&&&"+code);
                return false;
            }
            else
            {
                return true;
            }
        }
    </script>
    <style>
        table td {
            font-size: 19px;
        }

        label {
            cursor: pointer;
            margin-right: 1em;
        }
    </style>

</head>
<!-- body -->
<body>
<div id="box"></div>
<div class="cent-box register-box">
    <div class="cent-box-header">
        <h1 class="main-title hide">千寻</h1>
        <h2 class="sub-title">生活热爱分享 - Thousands Find</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="jsp/login.jsp">登录</a>
                <a href="jsp/register.jsp" class="active">注册</a>
                <div class="slide-bar slide-bar1"></div>
            </div>
        </div>

        <form class="login form" action="RegisterServlet" method="post">
            <ol class="group">
                <div class="group-ipt email">
                    <span class="field-validation-valid" data-valmsg-for="phoneNum" data-valmsg-replace="true"></span>
                    <input id="email" class="ipt" name="phoneNum" type="text" placeholder="手机号码" required value="">
                </div>
                <div class="group-ipt user">
                    <span class="field-validation-valid" data-valmsg-for="uname" data-valmsg-replace="true"></span>
                    <input id="user" class="ipt" name="uname" type="text" placeholder="用户名" required value="">
                </div>
                <div class="group-ipt password">
                    <span class="field-validation-valid" data-valmsg-for="passwd" data-valmsg-replace="true"></span>
                    <input id="password" class="ipt" name="passwd" type="password" placeholder="设置登录密码" required>
                </div>
                <div class="group-ipt password1">
                    <span class="field-validation-valid" data-valmsg-for="Confirmpasswd" data-valmsg-replace="true"></span>
                    <input id="password1" class="ipt" name="Confirmpasswd" type="password" placeholder="重复密码" required>
                </div>
                <div class="group-ipt verify">
                    <span class="field-validation-valid" data-valmsg-for="code" data-valmsg-replace="true"></span>
                    <input type="text" name="verify" id="verify" class="ipt" placeholder="输入验证码" required>
                    <img src="http://zrong.me/home/index/imgcode?id=" class="imgcode">
                </div>
            </ol>
        </form>

        <div class="button">
            <button type="submit" class="login-btn register-btn" id="button" onclick="return checkCode(registerForm);">注册</button>
        </div>
    </div>
</div>

<div class="footer">
    <p>千寻 - Thousands Find</p>
    <p>Designed By Maggie | 2018</p>
</div>

<script>
    $('.imgcode').hover(function(){
        layer.tips("看不清？点击更换", '.verify', {
            time: 6000,
            tips: [2, "#3c3c3c"]
        })
    },function(){
        layer.closeAll('tips');
    }).click(function(){
        $(this).attr('src','http://zrong.me/home/index/imgcode?id=' + Math.random());
    })

    $(".login-btn").click(function(){
        var email = $("#email").val();
        var password = $("#password").val();
        var verify = $("#verify").val();
        // $.ajax({
        // url: 'http://www.zrong.me/home/index/userLogin',
        // type: 'post',
        // jsonp: 'jsonpcallback',
        //       jsonpCallback: "flightHandler",
        // async: false,
        // data: {
        // 	'email':email,
        // 	'password':password,
        // 	'verify':verify
        // },
        // success: function(data){
        // 	info = data.status;
        // 	layer.msg(info);
        // }
        // })

    })
    $("#remember-me").click(function(){
        var n = document.getElementById("remember-me").checked;
        if(n){
            $(".zt").show();
        }else{
            $(".zt").hide();
        }
    })
</script>

</body>
</html>