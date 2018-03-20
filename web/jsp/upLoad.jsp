<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>上传商品</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">


    <script src="js/kit.js"></script>
    <!--[if IE]>
    <script src="js/ieFix.js"></script>
    <![endif]-->
    <script src="js/dom.js"></script>
    <script src="js/form.js"></script>
    <link rel="stylesheet" href="css/css.css"/>
    <link rel="stylesheet" href="css/upload.css"/>
    <link rel="stylesheet" href="css/validator.css"/>
    <!--validator-->
    <script src="js/validator.js"></script>
    <script src="js/autowired.validator.js"></script>
</head>

<body>
<%
    String strUid = "";
    if (null == session.getAttribute("uid")) {
        response.sendRedirect("login.jsp");
        return;
    }
    strUid = session.getAttribute("uid").toString();
    int uid = 0;
    if (strUid != null) {
        uid = Integer.parseInt(strUid);
    }
%>
<h1>上传商品</h1>
<div id="upload-main">
    <form id="uploadForm" action="UploadServlet" enctype="multipart/form-data" method="post">
        <ol>
            <li><label for="gname"></label>

            <li>
                <label for="gname">商品名：
                    <span class="kitjs-validator" for="@gname" rules="[{notNull:true, message:'商品名不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="gname" data-valmsg-replace="true"></span>
                <input id="gname" name="gname" type="text" value="">
            </li>

            <li>
                <label for="number">数量：
                    <span class="kitjs-validator" for="@number" rules="[{notNull:true, message:'数量不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="number" data-valmsg-replace="true"></span>
                <input id="number" name="number" type="number">
            </li>

            <li>
                <label for="types">类型：
                    <span class="kitjs-validator" for="@types" rules="[{notNull:true, message:'类型不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="types" data-valmsg-replace="true"></span>
                <select id="types" name="types">
                    <option>化妆品</option>
                    <option>衣服配饰</option>
                    <option>电子产品</option>
                    <option>生活用品</option>
                    <option>学习用品</option>
                    <option>其他</option>
                </select>
            </li>

            <li>
                <label for="price">价格：
                    <span class="kitjs-validator" for="@price" rules="[{notNull:true, message:'价格不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="price" data-valmsg-replace="true"></span>
                <input id="price" name="price" type="number">
            </li>

            <li>
                <label for="carriage">运费：
                    <span class="kitjs-validator" for="@carriage" rules="[{notNull:true, message:'运费不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="carriage" data-valmsg-replace="true"></span>
                <input id="carriage" name="carriage" type="number"></li>

            <li>
                <label for="producer">产地：
                <span class="kitjs-validator" for="@producer" rules="[{notNull:true, message:'产地不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="producer" data-valmsg-replace="true"></span>
                <input id="producer" name="producer" type="text">
            </li>

            <li>
                <label for="paddress">校区：
                <span class="kitjs-validator" for="@paddress" rules="[{notNull:true, message:'校区不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="paddress" data-valmsg-replace="true"></span>
                <input id="paddress" name="paddress" type="text"></li>

            <li>
                <label for="described">商品描述：
                    <span class="kitjs-validator" for="@described" rules="[{notNull:true, message:'商品描述不能为空'}]"></span>
                </label>
                <span class="field-validation-valid" data-valmsg-for="described" ata-valmsg-replace="true"></span>
                <textarea id="described" name="described"></textarea>
            </li>


            <li>
                <label for="gphoto">商品图片（上传三张）： </label>
            </li>

            <ul>
            <span
                    class="kitjs-validator" for="@gphoto"
                    rules="[{notNull:true, message:'图片不能为空'}]">

            </span>

                <span class="field-validation-valid" data-valmsg-for="gphoto" data-valmsg-replace="true"></span>
                <input type="text" name="photo1" id="photo1" readonly
                       style="margin:0px 5px 0px 0px;width: 285px;line-height: 33px;border: 1px solid #ccd1d5;display:inline;border-radius: 5px;">
                <input type="button" value="浏览" onclick="path1.click()"
                       style="width:60px; display:inline;border:1px solid #ccc; ">
                <input type="file" id="path1" name=ghpoto1 style="display:none" onchange="photo1.value=this.value">

                <input type="text" name="photo2" id="photo2" readonly
                       style="margin:5px 5px 5px 0px;width: 285px;line-height: 33px;border: 1px solid #ccd1d5;display:inline;border-radius: 5px;">
                <input type="button" value="浏览" onclick="path2.click()"
                       style="width:60px; display:inline;border:1px solid #ccc; ">
                <input type="file" id="path2" name=ghpoto2 style="display:none" onchange="photo2.value=this.value">

                <input type="text" name="photo3" id="photo3" readonly
                       style="margin:5px 5px 5px 0px;width: 285px;line-height: 33px;border: 1px solid #ccd1d5;display:inline;border-radius: 5px;">
                <input type="button" value="浏览" onclick="path3.click()"
                       style="width:60px; display:inline;border:1px solid #ccc; ">
                <input type="file" id="path3" name=ghpoto3 style="display:none" onchange="photo3.value=this.value">

             </ul>

            <input type="submit" value="提交" class="_submit">
    </form>
</div>
</body>
</html>
