package com.shopp.control;

import com.shopp.model.CollectionOperations;
import com.shopp.model.GoodsOperations;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class DeleteGServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        int gid = Integer.parseInt(request.getParameter("gid"));
        GoodsOperations go=new GoodsOperations();
        try {
            if (go.deleteGoods(gid)) {
                CollectionOperations co = new CollectionOperations();
                co.deleteGoodsByGid(gid);
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
