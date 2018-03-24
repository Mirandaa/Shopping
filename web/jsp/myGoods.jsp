<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:20
  To change this template use File | Settings | File Templates.
--%>

<%@page import="com.shopp.model.GoodsOperations"%>
<%@page import="com.shopp.bean.Goods"%>
<%@page import="com.shopp.bean.Collection"%>
<%@page import="java.util.List"%>
<%@page import="com.shopp.model.CollectionOperations"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>搜索</title>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css"
          media="all" />
    <link href="css/another_style.css" rel="stylesheet" type="text/css"
          media="all" />
    <link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/memenu.js"></script>
    <script type="text/javascript" src="js/simplecollection.min.js"></script>
    <script type="text/javascript">
        function confirmBuy() {
            return confirm("确定支付吗？");
        }
        function confirmDelete() {
            return confirm("确认删除订单吗");
        }
    </script>
</head>
<body>
<%--<jsp:include page="head.jsp"></jsp:include>--%>
<div class="container">
    <div class="check-out">
        <table>
            <tr>
                <th>商品</th>
                <th>数量</th>
                <th>价格</th>
                <th>运费</th>
                <th>总价</th>
            </tr>
            <%
                String strUid ="";
                if(null==session.getAttribute("uid"))
                {
                    response.sendRedirect("login.jsp");
                    return;
                }
                strUid=session.getAttribute("uid").toString();
                int uid = 0;
                if (strUid != null) {
                    uid = Integer.parseInt(strUid);
                }
                //	CollectionOperations co=new CollectionOperations();
                GoodsOperations go=new GoodsOperations();
                List<Goods> goodsList = go.getGoodsListByUid(uid);
                float allTotalPrice = 0;
                int allTotalNumber = 0;
                if (goodsList != null & goodsList.size() > 0) {
                    //Collection collection;
                    Goods goods;
                    String photoPath;
                    int number;
                    float price;
                    float totalPrice=0;
                    int gid;
                    for (int i = 0; i < goodsList.size(); i++) {
                        //collection = collectionList.get(i);
                        goods = goodsList.get(i);
                        photoPath = "images/" + goods.getGname() + "1.jpg";
                        number = goods.getNumber();
                        price = goods.getPrice();
                        gid = goods.getGid();
                        totalPrice = number * price + goods.getCarriage();
                        allTotalPrice = allTotalPrice + totalPrice;
                        allTotalNumber = allTotalNumber + number;
            %>
            <tr>
                <td class="ring-in"><a
                        href="jsp/goodsDescribed.jsp?gid=<%=goods.getGid()%>"
                        class="at-in"> <img src="<%=photoPath%>"
                                            class="img-responsive" alt="">
                </a>
                    <a href="#edittarget"></a>
                    <a name="edittarget"></a>
                    <div class="sed">
                        <h5>
                            商品名：<%=goods.getGname()%></h5>
                        <br>
                        <p>
                            上传时间：<%=goods.getudate()%></p>
                    </div>
                    <div class="clearfix"></div></td>
                <td><%=number%></td>
                <td><%=price%>元</td>
                <td><%=goods.getCarriage()%>元</td>
                <td><%=totalPrice%>元</td>
                <td><a
                        href="DeleteGServlet?gid=<%=gid%>&number=<%=number%>"
                        onclick="return confirmDelete()">删除</a></td>
                <td><a href="jsp/editGoods.jsp?gid=<%=gid%>">修改</a></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        <a>总计：<%=allTotalPrice%>元
        </a> &nbsp;&nbsp;&nbsp;
        <a><%=allTotalNumber%>件
        </a> &nbsp;&nbsp;&nbsp;
    </div>
</div>
</body>
</html>
