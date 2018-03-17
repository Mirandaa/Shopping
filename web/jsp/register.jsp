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
    <link rel="stylesheet" href="css/validator.css" />
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
    <!--手机验证码-->
    <script type="text/javascript">
        var InterValObj; //timer变量，控制时间
        var count = 60; //间隔函数，1秒执行
        var curCount;//当前剩余秒数
        var code = ""; //验证码
        var codeLength = 6;//验证码长度
        function sendMessage() {
//产生验证码
            for (var i = 0; i < codeLength; i++) {
                code += parseInt(Math.random() * 9).toString();
            }

//设置button效果，开始计时
            curCount = count;
            $("#btnSendCode").attr("disabled", "true");
            document.getElementById('btnSendCode').style.backgroundColor = "#d0d0d0";
            document.getElementById('btnSendCode').style.cursor = "no-drop";
            $("#btnSendCode").val(+curCount + "秒再获取");
            InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
//发送邮件
            $.post('jsp/sendMail.jsp', {code:jQuery.trim(code),email:jQuery.trim($('#email').val())},function(msg) {
                var dealType; //验证方式
                var uid = $("#uid").val();//用户uid
                if ($("#phone").attr("checked") == true) {
                    dealType = "phone";
                }
                else {
                    dealType = "email";
                }
            });
//向后台发送处理数据
            $.ajax({
                type: "POST", //用POST方式传输
                dataType: "text", //数据格式:JSON
                url: 'sendMail.jsp', //目标地址
                data: "dealType=" + dealType +"&uid=" + uid + "&code=" + code + "&email=" + ($('#email').val()),
                error: function (XMLHttpRequest, textStatus, errorThrown) { },
                success: function (msg){ }
            });
        }
        //timer处理函数
        function SetRemainTime() {
            if (curCount == 0) {
                window.clearInterval(InterValObj);//停止计时器
                $("#btnSendCode").removeAttr("disabled");//启用按钮
                document.getElementById('btnSendCode').style.backgroundColor="#fff";
                document.getElementById('btnSendCode').style.cursor="pointer";
                $("#btnSendCode").val("重新发送验证码");
                code = ""; //清除验证码。如果不清除，过时间后，输入收到的验证码依然有效
            }
            else {
                curCount--;
                $("#btnSendCode").val( + curCount + "秒再获取");
            }
        }
        //输入信息的判定
        function checkCode(){
            var reg_username = document.forms["regis"]["uname"].value;
            var reg_email = document.forms["regis"]["email"].value;
            var reg_pass = document.forms["regis"]["passwd"].value;
            var reg_repass = document.forms["regis"]["Confirmpasswd"].value;
            if(reg_username == null || reg_username == "")
            {
                $('#user').css('color','red');
                return false;
            }else if(reg_email == null || reg_email == ""){
                $('#email').css('color','red');
                return false;
            }
            var atpos = reg_email.indexOf("@");
            var dotpos = reg_email.indexOf(".");
            if(atpos<1 || dotpos<atpos+2 || dotpos+2 >= reg_email.length){
                alert("请输入有效邮箱地址");
                return false;
            }
            if(reg_pass == null || reg_pass == ""){
                alert("请输入密码");
                return false;
            }
            if(reg_repass == null || reg_repass == ""){
                alert("请重新输入密码");
                return false;
            }
            var pass_length = reg_pass.length;
            if(pass_length < 6){
                alert("密码位数不少于六");
                return false;
            }
            if(reg_repass!=reg_pass){
                alert("两次输入密码不同");
                return false;
            }
            //判断验证码是否正确
            var x = document.forms["regis"]["verify"].value;
            if(x==""){
                alert("请输入验证码");
                return false;
            }
            else if(x!=code){
                alert("验证码错误,请重试");
                return false;
            }
            else
            {
                return true;
            }
        }

    </script>
    <%--<script language="javascript">--%>
        <%--var code;--%>
 <%--       function send_mess(){
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
        };--%>
        <%--var iTime=59;--%>
        <%--var Account;--%>
        <%--function RemainTime(){--%>
            <%--document.getElementById('code_btn').disabled = true;--%>
            <%--var iSecond,sSecond="",sTime="";--%>
            <%--if (iTime >= 0){--%>
                <%--iSecond = parseInt(iTime%60);--%>
                <%--iMinute = parseInt(iTime/60)--%>
                <%--if (iSecond >= 0){--%>
                    <%--if(iMinute>0){--%>
                        <%--sSecond = iMinute + "分" + iSecond + "秒";--%>
                    <%--}else{--%>
                        <%--sSecond = iSecond + "秒";--%>
                    <%--}--%>
                <%--}--%>
                <%--sTime=sSecond;--%>
                <%--if(iTime==0){--%>
                    <%--clearTimeout(Account);--%>
                    <%--sTime='获取手机验证码';--%>
                    <%--iTime = 59;--%>
                    <%--document.getElementById('code_btn').disabled = false;--%>
                <%--}else{--%>
                    <%--Account = setTimeout("RemainTime()",1000);--%>
                    <%--iTime=iTime-1;--%>
                <%--}--%>
            <%--}else{--%>
                <%--sTime='没有倒计时';--%>
            <%--}--%>
            <%--document.getElementById('code_btn').value = sTime;--%>
        <%--}--%>
        <%--function checkCode(form){
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
        }--%>
    <%--</script>--%>

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

        <form class="login form" action="RegisterServlet" method="post" name = "regis">
            <ol class="group">
                <span id="msg"></span>
                <div class="group-ipt email">
                    <span class="field-validation-valid" data-valmsg-for="email" data-valmsg-replace="true"></span>
                    <input id="email" class="ipt" name="email" type="text" placeholder="邮箱账号" required value="">

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
                    <input id="btnSendCode" type="button" value="获取验证码" onClick="sendMessage()" />
                </div>
            </ol>
            <div class="button">
                <button type="submit" class="login-btn register-btn" id="button" onclick="return checkCode();">注册</button>
            </div>
        </form>
    </div>
</div>

<div class="footer">
    <p>千寻 - Thousands Find</p>
    <p>Designed By Maggie | 2018</p>
</div>

<script type="text/javascript">
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