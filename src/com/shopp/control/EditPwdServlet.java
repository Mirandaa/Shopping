package com.shopp.control;

import com.shopp.model.UserOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class EditPwdServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    /**
     * The doPost method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to post.
     *
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String passwd = request.getParameter("passwd");
        String phone = request.getParameter("phoneNum");
        String path = "jsp/forgetPwd.jsp";
        String message = "找回密码失败，该手机号还未注册!";
        UserOperations uo=new UserOperations();
        try {
            if (uo.findPasswd(phone, passwd)) {
                message = "修改密码成功";
                path = "jsp/login.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String truePath = request.getContextPath() + "/" + path;
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>找回密码</TITLE>");
        out.println("<meta http-equiv=\"refresh\" content=\"5;url=" + truePath
                + "\">");
        out.println("</HEAD>");
        out.println("  <BODY>");
        out.print("<div align=\"center\">");
        out.print(message);
        out.print("<br/>");
        out.print("将自动跳转到相应页面");
        out.print("<br/>");
        out.print("或点击这里：");
        out.print("<a href=\"" + truePath + "\"" + ">返回" + "</a>");
        out.print("</div>");
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

}
