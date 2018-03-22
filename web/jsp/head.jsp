<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:21
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.shopp.model.GoodsOperations"%>
<%@page import="com.shopp.bean.Goods"%>
<%@page import="java.util.List"%>

<%@ page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%
    String uname = (String) session.getAttribute("uname");
    String uid = String.valueOf(session.getAttribute("uid"));
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css"
          media="all" />
    <link href="css/another_style.css" rel="stylesheet" type="text/css"
          media="all" />
    <link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/responsiveslides.min.js"></script>
    <script type="text/javascript" src="js/memenu.js"></script>
    <script>
        $(document).ready(function() {
            $(".memenu").memenu();
        });
    </script>
    <script type="text/javascript">
        function key() {
            return confirm("确定退出吗？");
        }
    </script>
    <script>
        function showtime() {
            var myDate = new Date();
            document.getElementById("time").innerHTML = myDate.getHours() + "点"
                + myDate.getMinutes() + "分" + myDate.getSeconds() + "秒";
            setTimeout("showtime()", 1000);
        }
    </script>

</head>
<body>
<!--header-->
<div class="header">
    <div class="header-top">
        <div class="container">
            <div class="col-sm-4 logo">
                <a href="index.jsp"><img src="images/logo1.png" alt=""></a></div>
            <div class="col-sm-4 world">
                <form action="/jsp/findResult.jsp" method="post" name="query">
                    <input type="text" name="find_value" id="find_value">
                    <img src="../images/search.png" class="searchImg">
                    <input type="submit" value="查询" id="search">
                </form>
            </div>
            <div class="col-sm-4 header-left">
                <p class="log">
                    <%
                        if (uname != null) {
                            out.print("<a>" + uname + ",欢迎登录" + "</a>");
                            out.print("<a>|</a>");
                            out.print("<a href=\"jsp/showMessage.jsp\" >" + "个人信息" + "</a>");
                            out.print("<a>|</a>");
                            out.print("<a href=\"jsp/upLoad.jsp\" >" + "发布商品" + "</a>");
                            out.print("<a>|</a>");
                            out.print("<a href=\"LogoutServlet\" onClick=\"return key()\">" + "退出" + "</a>");
                        } else {
                            out.print("<a href=\"jsp/login.jsp\">登录</a>");
                            out.print("<a>|</a>");
                            out.print("<a href=\"jsp/register.jsp\">注册</a>");
                        }
                    %>
                </p>
                <%--<div class="cart box_1">--%>
                    <%--<form name="form_collection">--%>
                        <%--<a href="jsp/collection.jsp"> <img src="images/empty_25.png" onmousemove="this.src='images/full_collection_25.png'"--%>
                                                           <%--onmouseout="this.src='images/empty_25.png'"	alt="" />--%>
                        <%--</a>--%>
                    <%--</form>--%>
                <%--</div>--%>
                <%--<div class="cart box_1">--%>
                    <%--<form name="form_collection">--%>
                        <%--<a href="jsp/upLoad.jsp"> <img src="images/add_red_25.png" onmousemove="this.src='images/add_white_25.png'"--%>
                                                       <%--onmouseout="this.src='images/add_red_25.png'"	alt="" />--%>
                        <%--</a>--%>
                    <%--</form>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="head-top">
            <div class="col-sm-8 h_menu4">
                <ul class="memenu skyblue">
                    <li class="grid"><a href="index.jsp">首页</a></li>
                    <div class="cutline"></div>
                    <li><a>分类</a>
                        <div class="mepanel">
                            <div class="row">
                                <%
                                    GoodsOperations go = new GoodsOperations();
                                    String[] types = go.queryTypes();
                                    if (types != null & types.length > 0) {
                                        String type;
                                        List<Goods> goodsList;
                                        Goods goods;
                                        for (int i = 0; i < types.length; i++) {
                                            if (types[i] != null & !"".equals(types[i])) {
                                                type = types[i];
                                                goodsList = go.getTypeGoodsList(type);
                                %>
                                <div class="col1">
                                    <div class="h_nav">
                                        <h4><%=type%></h4>
                                        <ul>
                                            <%
                                                if (goodsList != null & goodsList.size() > 0) {
                                                    for (int j = 0; j < goodsList.size(); j++) {
                                                        goods = goodsList.get(j);
                                            %>
                                            <li><a
                                                    href="jsp/goodsDescribed.jsp?gid=<%=goods.getGid()%>"
                                                    target="_blank"><%=goods.getGname()%></a></li><br><br>
                                            <%
                                                    }
                                                }
                                            %>
                                        </ul>
                                    </div>
                                </div>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </div>
                        </div></li>
                    <%--<div class="cutline"></div>--%>
                    <%--<li><a href="jsp/collection.jsp">收藏</a></li>--%>
                    <%--<div class="cutline"></div>--%>
                    <%--<li><a href="jsp/myGoods.jsp">我的商品</a></li>--%>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>