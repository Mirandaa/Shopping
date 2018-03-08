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
    <title>用户注册</title>
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
<h1>欢迎注册</h1>
<div id="register-main">
    <form id="registerForm" action="RegisterServlet" method="post">
        <ol>
            <li><label for="uname">用户名： <span
                    class="kitjs-validator" for="@uname"
                    rules="[{notNull:true, message:'用户名不能为空'}]"></span>
            </label> <span class="field-validation-valid" data-valmsg-for="uname"
                           data-valmsg-replace="true"></span>
                <input id="uname" name="uname" type="text" value=""></li>


            <li><label for="phoneNum">手机号码： <span
                    class="kitjs-validator" for="@phoneNum"
                    rules="[{notNull:true, message:'手机号码不能为空'}]"></span>
            </label> <span class="field-validation-valid" data-valmsg-for="phoneNum"
                           data-valmsg-replace="true"></span>
                <input id="phoneNum" name="phoneNum" type="text" value="">
                <input id="code_btn" name="code_btn" type="button" value="获取验证码" onclick="send_mess();">
            </li>

            <li><label for="code">验证码： <span
                    class="kitjs-validator" for="@code"
                    rules="[{notNull:true, message:'验证码不能为空'}]"></span>
            </label> <span class="field-validation-valid" data-valmsg-for="code"
                           data-valmsg-replace="true"></span>
                <input id="code" name="code" type="text" value=""></li>

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
        <div class="registerError"></div>
        <input type="submit" value="注册" class="btn-register" onclick="return checkCode(registerForm);">
    </form>
</div>
</body>
</html>