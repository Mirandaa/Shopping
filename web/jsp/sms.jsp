<%--
  Created by IntelliJ IDEA.
  User: Maggie
  Date: 2018/3/6
  Time: 下午7:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%><%@ page import = "java.io.*" %><%@ page import = "java.net.*" %><%@ page import = "java.util.*" %><%@ page import = "java.lang.*" %><%

    //接口类型：互亿无线触发短信接口，支持发送验证码短信、订单通知短信等。
    // 账户注册：请通过该地址开通账户http://sms.ihuyi.com/register.html
    // 注意事项：
    //（1）调试期间，请用默认的模板进行测试，默认模板详见接口文档；
    //（2）请使用APIID（查看APIID请登录用户中心->验证码、通知短信->帐户及签名设置->APIID）及 APIkey来调用接口；
    //（3）该代码仅供接入互亿无线短信接口参考使用，客户可根据实际需要自行编写；

    String postUrl = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";

    int mobile_code = (int)((Math.random()*9+1)*100000); //获取随机数

    String account = "C43231176"; //查看用户名请登录用户中心->验证码、通知短信->帐户及签名设置->APIID
    String password = "c19de3e0bcb190ca3a10f0facba16e9a";  //查看密码请登录用户中心->验证码、通知短信->帐户及签名设置->APIKEY
//String mobile = "15281167876";
    String mobile = request.getParameter("phoneNum");
    String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。");

    try {

        URL url = new URL(postUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);//允许连接提交信息
        connection.setRequestMethod("POST");//网页提交方式“GET”、“POST”
        connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        connection.setRequestProperty("Connection", "Keep-Alive");
        StringBuffer sb = new StringBuffer();
        sb.append("account="+account);
        sb.append("&password="+password);
        sb.append("&mobile="+mobile);
        sb.append("&content="+content);
        OutputStream os = connection.getOutputStream();
        os.write(sb.toString().getBytes());
        os.close();

        String line, result = "";
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
        while ((line = in.readLine()) != null) {
            result += line + "\n";
        }
        in.close();
        out.println(result+mobile_code);

    } catch (IOException e) {
        e.printStackTrace(System.out);
    }

%>