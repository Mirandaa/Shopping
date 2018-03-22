<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午2:47
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
    <title>登录 - 千寻 - Thousands Find</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <%--<script src="js/dom.js" type="javascript"></script>--%>
    <%--<script src="js/form.js" type="javascript"></script>--%>
    <link rel="stylesheet" href="css/login.css" />
    <!--validator-->
    <script src="js/validator.js" type="javascript"></script>
    <script src="js/autowired.validator.js" type="javascript"></script>
    <!--background-->
    <script src="js/background.js" type="javascript"></script>
    <script src="js/kit.js" type="javascript"></script>
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
</head>
<body>
<div id="box"></div>
<div class="cent-box">
    <div class="cent-box-header">
        <h1 class="main-title hide">千寻</h1>
        <h2 class="sub-title">生活热爱分享 - Thousands Find</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="jsp/login.jsp" class="active">登录</a>
                <a href="jsp/register.jsp">注册</a>
                <div class="slide-bar"></div>
            </div>
        </div>

        <form class="login form" action="LoginServlet" method="post">
            <ol class="group">
                <div class="group-ipt email">
                    <span class="field-validation-valid" data-valmsg-for="email" data-valmsg-replace="true"></span>
                    <input id="email" name="email" type="text" class="ipt" placeholder="输入邮箱" required value="">
                </div>
                <div class="group-ipt password">
                    <%--<span class="field-validation-valid" data-valmsg-for="passwd" data-valmsg-replace="true"></span>--%>
                    <input id="password" name="passwd" type="password" class="ipt" placeholder="输入您的登录密码" >
                </div>
            </ol>

            <div class="button">
                <button type="submit" class="login-btn register-btn" id="button">登录</button>
            </div>

            <div class="remember clearfix">
                <label class="remember-me">
                    <span class="icon">
                        <span class="zt"></span>
                    </span>
                    <input type="checkbox" name="remember-me" id="remember-me" class="remember-mecheck" checked>记住我</label>
                <label class="forgot-password">
                    <a href="jsp/forgetPwd.jsp">忘记密码？</a>
                </label>
            </div>
        </form>
    </div>
</div>

<div class="footer">
    <p>千寻 - Thousands Find</p>
    <p>Designed By Maggie | 2018</p>
</div>

<script>
    $("#remember-me").click(function(){
        var n = document.getElementById("remember-me").checked;
        if(n) {
            $(".zt").show();
        } else {
            $(".zt").hide();
        }
    });
</script>
<script type="text/javascript">
    window.onload = function() {
        //配置
        var config = {
            vx: 4,	//小球x轴速度,正为右，负为左
            vy: 4,	//小球y轴速度
            height: 2,	//小球高宽，其实为正方形，所以不宜太大
            width: 2,
            count: 100,		//点个数
            color: "121, 162, 185", 	//点颜色
            stroke: "130,255,255", 		//线条颜色
            dist: 6000, 	//点吸附距离
            e_dist: 20000, 	//鼠标吸附加速距离
            max_conn: 5 	//点到点最大连接数
        }

        //调用
        CanvasParticle(config);
    }
</script>

</body>
</html>