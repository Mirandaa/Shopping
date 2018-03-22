<%@ page import="com.shopp.model.GoodsOperations" %>
<%@ page import="com.shopp.bean.Goods" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/3/21
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    int order = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>查询</title>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="css/another_style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <link href="css/order.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/responsiveslides.min.js"></script>
    <script type="text/javascript" src="../js/selected.js"></script>

</head>
<script type="text/javascript">
   window.ready(function(){
       $('#byprice').show();
       $('#bytime').hide();
       $('#pricebutton').click(function () {
           $('#byprice').show();
           $('#bytime').hide();
       })
   })
</script>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    <div class="content">
        <div class="orderBy" id="orderBy">
            <ol>
                <button id="pricebutton">按价格</button>
                <button id="timebutton">按发布时间</button>
            </ol>
        </div>
        <%		//定义四个分页会用到的变量
            int pageSize=8;
            int pageNow=1;//默认显示第一页
            int rowCount=0;//该值从数据库中查询
            int pageCount=0;//该值是通过pageSize和rowCount
            //接受用户希望显示的页数（pageNow）
            String s_pageNow=request.getParameter("pageNow");
            if(s_pageNow!=null){
                //接收到了pageNow
                pageNow=Integer.parseInt(s_pageNow);
            }
            //查询得到rowCount
        %>
        <div class="container" id="bytime">
            <div class="content-top">
                <%
                    GoodsOperations go = new GoodsOperations();
                    String value = request.getParameter("find_value");
                    List<Goods> goodsList;
                    goodsList = go.getGoodsListByKeyValue(value,order);
                    rowCount = goodsList.size();
                    //计算pageCount
                    if(rowCount%pageSize==0){
                        pageCount=rowCount/pageSize;
                    }else{
                        pageCount=rowCount/pageSize+1;
                    }
                    if (goodsList != null && goodsList.size() > 0) {
                        for (int i = (pageNow-1)*pageSize; i < pageNow*pageSize; i++) {
                            if(i==goodsList.size()-1) {
                %>
                <div class="clearfix"></div>
            </div>
            <%
                    break;
                }
                if (i % 4 == 0) {
            %>

            <div class="content-top1">
                <%
                    }
                %>
                <div class="col-md-3 col-md2">
                    <div class="col-md1 simpleCart_shelfItem">
                        <a
                                href="jsp/goodsDescribed.jsp?gid=<%=goodsList.get(i).getGid()%>"
                                target="_blank"> <%
                            String photoPath = "images/" + goodsList.get(i).getGname()
                                    + "1.jpg";
                        %> <img class="img-responsive" src=<%=photoPath%> alt="图片" />
                        </a>
                        <h3>
                            <a href="jsp/goodsDescribed.jsp?gid=<%=goodsList.get(i).getGid()%>" target="_blank"><%=goodsList.get(i).getGname()%></a>
                        </h3>
                        <div class="price">
                            <h5 class="item_price"><%=goodsList.get(i).getPrice()%>元
                            </h5>
                            <a  href="CollectServlet?gid=<%=goodsList.get(i).getGid()%>&buyNumber=1"
                                class="item_add" onclick="checkSuccess()">收藏</a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <%
                    if (i % 4 == 3) {
                %>
                <div class="clearfix"></div>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>

        <div class="container" id="byprice" >
            <%		//定义四个分页会用到的变量
                pageSize=8;
                pageNow=1;//默认显示第一页
                rowCount=0;//该值从数据库中查询
                pageCount=0;//该值是通过pageSize和rowCount
                //接受用户希望显示的页数（pageNow）
                s_pageNow=request.getParameter("pageNow");
                if(s_pageNow!=null){
                    //接收到了pageNow
                    pageNow=Integer.parseInt(s_pageNow);
                }
                //查询得到rowCount
                go = new GoodsOperations();
                value = request.getParameter("find_value");
                order=1;
                goodsList = go.getGoodsListByKeyValue(value,order);
                rowCount = goodsList.size();
                //计算pageCount
                if(rowCount%pageSize==0){
                    pageCount=rowCount/pageSize;
                }else{
                    pageCount=rowCount/pageSize+1;
                }
            %>
            <div class="content-top">
                <%

                    if (goodsList != null && goodsList.size() > 0) {
                        for (int i = (pageNow-1)*pageSize; i < pageNow*pageSize; i++) {
                            if(i==goodsList.size()-1) {
                %>
                <div class="clearfix"></div>
            </div>
            <%
                    break;
                }
                if (i % 4 == 0) {
            %>
            <div class="content-top1">
                <%
                    }
                %>
                <div class="col-md-3 col-md2">
                    <div class="col-md1 simpleCart_shelfItem">
                        <a
                                href="jsp/goodsDescribed.jsp?gid=<%=goodsList.get(i).getGid()%>"
                                target="_blank"> <%
                            String photoPath = "images/" + goodsList.get(i).getGname()
                                    + "1.jpg";
                        %> <img class="img-responsive" src=<%=photoPath%> alt="图片" />
                        </a>
                        <h3>
                            <a href="jsp/goodsDescribed.jsp?gid=<%=goodsList.get(i).getGid()%>" target="_blank"><%=goodsList.get(i).getGname()%></a>
                        </h3>
                        <div class="price">
                            <h5 class="item_price"><%=goodsList.get(i).getPrice()%>元
                            </h5>
                            <a  href="CollectServlet?gid=<%=goodsList.get(i).getGid()%>&buyNumber=1"
                                class="item_add" onclick="checkSuccess()">收藏</a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <%
                    if (i % 4 == 3) {
                %>
                <div class="clearfix"></div>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>

    <style>
        body{ text-align:center}
        .div{ margin:0 auto; width:400px; height:100px;}
        /* css注释：为了观察效果设置宽度 边框 高度等样式 */
    </style>

    <%//上一页
        if(pageNow!=1){
            out.println("<a href=index.jsp?pageNow="+(pageNow-1)+">上一页</a>");
        }else{
            out.println("上一页");
        }%>&nbsp
    <%//显示超链接
        for(int i=1;i<=pageCount;i++){
            if(i==pageNow)
                out.println(i);
            else out.println("<a href=index.jsp?pageNow="+i+">["+i+"]</a>");
        }%>&nbsp
    <%//下一页
        if(pageNow!=pageCount){
            out.println("<a href=index.jsp?pageNow="+(pageNow+1)+">下一页</a>");
        }else{
            out.println("下一页");
        }
    %>
</body>
</html>
