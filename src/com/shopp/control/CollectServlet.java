package com.shopp.control;

import com.shopp.model.CollectionOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CollectServlet extends HttpServlet {

    /**
     * The doGet method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to get.
     *
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
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
        try {
            PrintWriter pw=response.getWriter();
            String strUid =request.getSession().getAttribute("uid").toString();
            int uid=0;
            if(strUid!=null){
                uid = Integer.parseInt(strUid);
            }
            int gid = Integer.valueOf(request.getParameter("gid"));
            int number = Integer.valueOf(request.getParameter("buyNumber"));
            CollectionOperations co=new CollectionOperations();
            boolean flag=false;
            try {
                flag = co.addGoods(uid, gid, number);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag) {
                response.sendRedirect("index.jsp?flag=success");

            } else {
                response.sendRedirect("index.jsp?flag=fault");
            }

        } catch (Exception e) {
            // TODO: handle exception
            response.sendRedirect("jsp/login.jsp");
        }

    }
}
