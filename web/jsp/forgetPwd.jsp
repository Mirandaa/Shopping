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
    <script src="js/validator.js"></script>
    <script src="js/autowired.validator.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <!--background-->
    <script src="js/background.js" type="javascript"></script>
    <%--<script src="js/particles.js" type="javascript"></script>--%>

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

        <form class="login form" action="EditPwdServlet" method="post">
            <ol class="group">
                <div class="group-ipt verify">
                    <span class="field-validation-valid" data-valmsg-for="code" data-valmsg-replace="true"></span>
                    <input type="text" name="verify" id="verify" class="ipt" placeholder="输入手机号" required>
                    <%--<img src="http://zrong.me/home/index/imgcode?id=" class="imgcode">--%>
                </div>

                <div class="group-ipt user">
                    <span class="field-validation-valid" data-valmsg-for="code" data-valmsg-replace="true"></span>
                    <input id="code" name="code" type="text" class="ipt" placeholder="输入验证码" value="">
                </div>

                <div class="group-ipt">
                <li></li>
                    <span
                        class="kitjs-validator" for="@passwd"
                        rules="[{notNull:true, message:'密码不能为空'},{minLength:'6',message:'密码长度最短为6位'}]">
                    </span>
                    <span class="field-validation-valid" data-valmsg-for="passwd" data-valmsg-replace="true"></span>
                    <input id="password" name="passwd" type="password" placeholder="请输入密码">
                </li>
                </div>

                <div class="group-ipt">
                <li>
                    <span class="kitjs-validator" for="@Confirmpasswd" rules="[{notNull:true, message:'密码不能为空'},{equalWith:'@passwd',message:'密码输入不一致'},{minLength:'6',message:'密码长度最短为6位'}]"></span>
                    <span class="field-validation-valid" data-valmsg-for="Confirmpasswd" data-valmsg-replace="true"></span>
                    <input id="password1" name="Confirmpasswd" type="password" placeholder="请重新输入密码">
                </li>
                </div>
            </ol>
            <div class="registError"></div>
            <input type="submit" value="确认" class="btn-regist" id="button"  onclick="return checkCode(registForm);">
        </form>
    </div>
</div>
</body>
</html>