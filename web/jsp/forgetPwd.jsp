<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:22
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
    <title>找回密码 - 千寻 - Thousands Find</title>
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
    <script src="js/dom.js"></script>
    <script src="js/form.js"></script>
    <link rel="stylesheet" href="css/css.css" />
    <link rel="stylesheet" href="css/validator.css" />
    <link rel="stylesheet" href="css/login.css" />
    <!--validator-->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/messages_zh.js"></script>
    <!--background-->
    <script src="js/background.js" type="javascript"></script>
    <%--<script src="js/particles.js" type="javascript"></script>--%>
    <!--sendmessage-->
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
            $.post('jsp/sendMail.jsp', {
                code: jQuery.trim(code),
                email: jQuery.trim($('#verify').val())
            }, function (msg) {
                var dealType; //验证方式
                var uid = $("#uid").val();//用户uid
                if ($("#phone").attr("checked") == true) {
                    dealType = "phone";
                }
                else {
                    dealType = "email";
                }
            });

            //timer处理函数
            function SetRemainTime() {
                if (curCount == 0) {
                    window.clearInterval(InterValObj);//停止计时器
                    $("#btnSendCode").removeAttr("disabled");//启用按钮
                    document.getElementById('btnSendCode').style.backgroundColor = "#fff";
                    document.getElementById('btnSendCode').style.cursor = "pointer";
                    $("#btnSendCode").val("重新发送验证码");
                    code = ""; //清除验证码。如果不清除，过时间后，输入收到的验证码依然有效
                }
                else {
                    curCount--;
                    $("#btnSendCode").val(+curCount + "秒再获取");
                }
            }

            //判断验证码是否正确
            function checkCode() {
                alert("进入checkCode()");
                var x = document.forms["forget"]["code"].value;
                if (x == "") {
                    alert("请输入验证码");
                    return false;
                }
                else if (x != code) {
                    alert("验证码错误,请重试");
                    return false;
                }
                else {
                    return true;
                }
            }

            // 在键盘按下并释放及提交后验证提交表单
            $().ready(function () {
                $("#forget").validate({
                    rules: {
                        passwd: {
                            required: true,
                            minlength: 6
                        },
                        Confirmpasswd: {
                            required: true,
                            minlength: 6,
                            equalTo: "#password"
                        },
                        verify: {
                            required: true,
                            email: true
                        }
                    },
                    messages: {
                        passwd: {
                            required: "请输入密码",
                            minlength: "密码长度不能小于 6 个字母"
                        },
                        Confirmpasswd: {
                            required: "请输入密码",
                            minlength: "密码长度不能小于 6 个字母",
                            equalTo: "两次密码输入不一致"
                        },
                        verify: "请输入一个正确的邮箱"
                    }
                });
            });
        }
    </script>
    <style>
        .error{
            font-size:12px;
            color:red;
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
                <a href="jsp/forgetPwd.jsp" class="active">找回密码</a>
            </div>
        </div>

        <form class="login form" action="EditPwdServlet" method="post" id="forget" name="forget">
            <ol class="group">
                <div class="group-ipt verify">
                    <p>
                        <input type="text" name="verify" id="verify" class="ipt" placeholder="输入邮箱" required>
                    <input id="btnSendCode" type="button" value="获取验证码" onClick="sendMessage()" />
                    </p>
                    <%--<img src="http://zrong.me/home/index/imgcode?id=" class="imgcode">--%>
                </div>

                <div class="group-ipt user">
                    <p>
                    <input id="code" name="code" type="text" class="ipt" placeholder="输入验证码" value="">
                    </p>
                </div>

                <div class="group-ipt">

                    <p>
                   <input id="password" name="passwd" type="password" placeholder="请输入密码">
                    </p>
                </div>

                <div class="group-ipt">
                    <p>
                    <input id="password1" name="Confirmpasswd" type="password" placeholder="请重新输入密码">
                    </p>
                </div>
            </ol>
            <input type="submit" value="确认" class="btn-regist" id="button"  onclick="return checkCode();">
        </form>
    </div>
</div>
</body>
</html>