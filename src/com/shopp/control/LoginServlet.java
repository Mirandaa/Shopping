package com.shopp.control;

import com.shopp.bean.User;
import com.shopp.model.UserOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public LoginServlet() {
        super();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String phoneNum = request.getParameter("phoneNum");
        String passwd = request.getParameter("passwd");
        User user = null;
        String message = "";
        String path = "jsp/login.jsp";
        UserOperations uo=new UserOperations();
        try {
            if(uo.checkUser(phoneNum, passwd))
            {
                user=uo.getUser(phoneNum);
                request.getSession().setAttribute("uid", user.getUid());
                request.getSession().setAttribute("uname", user.getUname());
                request.getSession().setAttribute("LastLoginTime", user.getLastLogin());
                System.err.println(user.getUid()+user.getUname()+user.getLastLogin());
                path = "index.jsp";
            }
            else {
                message = "用户名或密码错误，请重试";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String truePath = request.getContextPath() + "/" + path;
        if ("".equals(message)) {
            response.sendRedirect(truePath);
        } else {
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
            out.println("<HTML>");
            out.println("  <HEAD><TITLE>登录出错</TITLE>");
            out.println("<meta http-equiv=\"refresh\" content=\"5;url="
                    + truePath + "\">");
            out.println("</HEAD>");
            out.println("  <BODY>");
            out.print("<div align=\"center\">");
            out.print(message);
            out.print("<br/>");
            out.print("将自动跳转到登录页面");
            out.print("<br/>");
            out.print("或点击这里返回：");
            out.print("<a href=\"" + truePath+"\"" +">登录"+"</a>");
            out.print("</div>");
            out.println("  </BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();
        }
    }

}
