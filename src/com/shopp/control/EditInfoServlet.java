package com.shopp.control;

import com.shopp.bean.Goods;
import com.shopp.model.GoodsOperations;
import com.shopp.model.UserOperations;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class EditInfoServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    /**
     * Constructor of the object.
     */
    public EditInfoServlet() {
        super();
    }

    /**
     * Destruction of the servlet. <br>
     */
    public void destroy() {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String uids = String.valueOf( request.getSession().getAttribute("uid"));
        int uid= Integer.parseInt(uids);
        int i = 0;
        int gid = Integer.parseInt(request.getParameter("gid"));
        String gname = request.getParameter("gname");
        int number = Integer.parseInt(request.getParameter("number"));
        String types = request.getParameter("types");
        String producer = request.getParameter("producer");
        float price = Float.parseFloat(request.getParameter("price"));
        float carriage = Float.parseFloat(request.getParameter("carriage"));
        String paddress = request.getParameter("paddress");
        String described = request.getParameter("described");
        String gphoto = gname+"1.jpg&"+gname+"2.jpg&"+gname+"3.jpg";
        Date date=new Date();
        DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String udate=format.format(date);
        try{
            Goods good = new Goods(gid, gname, number, gphoto, types,
                    producer, price,  carriage, "2017-06-27",
                    paddress,described, uid, udate);
            GoodsOperations go = new GoodsOperations();
            boolean flag = false;
            try {
                flag = go.editInfo(good);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag) {
                System.out.print("success");
                response.sendRedirect("jsp/showMessage.jsp");
            } else {
                System.out.print("success");
                response.sendRedirect("jsp/howMessage.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
