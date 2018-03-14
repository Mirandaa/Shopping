<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:19
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.shopp.model.UserOperations"%>
<%@page import="com.shopp.bean.User"%>

<%@ page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%
    String uid = String.valueOf(session.getAttribute("uid"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>个人信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="../css/showMessage.css" rel="stylesheet" type="text/css" media="all" />
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />

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
    <style>
        table td {
            font-size: 19px;
        }

        label {
            cursor: pointer;
            margin-right: 1em;
        }
    </style>

    <script type="text/javascript">
        function editInfo() {
            if (document.getElementById("submit").value == "编辑个人信息") {
                document.getElementById("username").disabled = false;
                document.getElementById("password").disabled = false;
                document.getElementById("submit").value = "确认修改";
                return false;
            }
            return true;
        }
    </script>

</head>
<body>
<jsp:include page="head.jsp"></jsp:include>
<div class="container">
<div class="all">
<div class="top">
    <div class="top_1"></div>
    <div class="top_2">
        <div class="title"><h1>个人信息</h1></div>
    </div>
    <div class="img"></div>
</div>

<div id="regist-main">
    <form id="registForm" action="EditInfoServlet" method="get">
        <ol>
            <%
                UserOperations uo = new UserOperations();
                User user = uo.queryByUid(uid);
                if (user != null) {

                }
            %>

            <li>
                <label for="username">用户名：
                    <span class="kitjs-validator" for="@username" rules="[{notNull:true, message:'用户名不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="username" data-valmsg-replace="true"></span>
                <input id="username" name="username" type="text" value="<%=user.getUname()%>" disabled="true">
            </li><hr>

            <label></label>

            <li>
                <label for="phoneNum">手机号码：</label>
                <input id="phoneNum" name="phoneNum" type="text" value="<%=user.getPhoneNum()%>" disabled="true">
            </li><hr>

            <label></label>

            <li>
                <label for="password">密码：
                    <span class="kitjs-validator" for="@password" rules="[{notNull:true, message:'密码不能为空'},{minLength:'6',message:'密码长度最少为6位'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="password" data-valmsg-replace="true"></span>
                <input id="password" name="password" type="password" value="<%=user.getPasswd()%>" disabled="true">
            </li><hr>

            <label></label>

            <li>
                <label for="phoneNum">上次登录时间： </label>
                <input id="phoneNum" name="phoneNum" type="text" value=<%=session.getAttribute("LastLoginTime")%> disabled="true">
            </li>

        </ol>
        <div class="registError"></div>
        <input id="submit" type="submit" value="编辑个人信息" class="btn-submit" onclick="return editInfo()">
    </form>
</div>
</div>
</div>
</body>
</html>