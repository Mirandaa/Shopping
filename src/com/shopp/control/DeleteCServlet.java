package com.shopp.control;

import com.shopp.model.CollectionOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class DeleteCServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 6062190138235133648L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String uid = String.valueOf(request.getSession().getAttribute("uid"));
        int gid = Integer.parseInt(request.getParameter("gid"));
        int number = Integer.parseInt(request.getParameter("number"));
        CollectionOperations co=new CollectionOperations();
        try {
            if (co.deleteGoods(Integer.parseInt(uid), gid, number)) {
               // response.sendRedirect("jsp/collection.jsp");
                response.sendRedirect("jsp/showMessage.jsp");
            } else {
                PrintWriter pw=response.getWriter();
                pw.println("删除失败");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
