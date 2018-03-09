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
    <link rel="stylesheet" href="css/login.css" />
    <link rel="stylesheet" href="css/validator.css" />
    <!--validator-->
    <script src="js/validator.js"></script>
    <script src="js/autowired.validator.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <!--background-->
    <script src="js/background.js" type="javascript"></script>
    <script src="js/particles.js" type="javascript"></script>
    <script language="javascript">
        var code;
        function send_mess(){
            $.post('jsp/sms.jsp', {phoneNum:jQuery.trim($('#phoneNum').val())}, function(msg) {
                code=unescape(msg).substr(unescape(msg).length-8,6);
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
                alert("验证码错误,请重试");
                return false;
            }
            else
            {
                return true;
            }
        }
    </script>

</head>
<!-- body -->
<body>
<div id="box"></div>
<div id="cent-box register-box">
    <div class="cent-box-header">
        <h1 class="main-title hide">千寻</h1>
        <h2 class="sub-title">生活热爱分享 - Thousands Find</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="jsp/forgetPwd.jsp" class="active">找回密码</a>
                <div class="slide-bar slide-bar1"></div>
            </div>
        </div>

        <form class="login form" action="EditPwdServlet" method="post">
            <ol class="group">
                <div class="group-ipt verify">
                    <span class="field-validation-valid" data-valmsg-for="code" data-valmsg-replace="true"></span>
                    <input type="text" name="verify" id="verify" class="ipt" placeholder="输入手机号" required>
                    <img src="http://zrong.me/home/index/imgcode?id=" class="imgcode">
                </div>

                <div class="group-ipt user">
                    <span class="field-validation-valid" data-valmsg-for="code" data-valmsg-replace="true"></span>
                    <input id="code" name="code" type="text" class="ipt" placeholder="输入验证码" value="">
                </div>

                <li><label for="passwd">密码： <span
                        class="kitjs-validator" for="@passwd"
                        rules="[{notNull:true, message:'密码不能为空'},{minLength:'6',message:'密码长度最短为6位'}]"></span>
                </label> <span class="field-validation-valid" data-valmsg-for="passwd"
                               data-valmsg-replace="true"></span>
                    <input id="passwd" name="passwd" type="password"></li>

                <li><label for="Confirmpasswd">重新输入密码： <span
                        class="kitjs-validator" for="@Confirmpasswd"
                        rules="[{notNull:true, message:'密码不能为空'},{equalWith:'@passwd',message:'密码输入不一致'},{minLength:'6',message:'密码长度最短为6位'}]"></span>
                </label> <span class="field-validation-valid"
                               data-valmsg-for="Confirmpasswd" data-valmsg-replace="true"></span>
                    <input id="Confirmpasswd" name="Confirmpasswd" type="password">
                </li>
            </ol>
            <div class="registError"></div>
            <input type="submit" value="确认" class="btn-regist" onclick="return checkCode(registForm);">
        </form>
    </div>
</div>
</body>
</html>