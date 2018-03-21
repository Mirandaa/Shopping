package com.shopp.control;

import com.shopp.model.UserOperations;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@WebServlet(name = "EditUImgServlet")
public class EditUImgServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String uids = String.valueOf( request.getSession().getAttribute("uid"));
        int uid= Integer.parseInt(uids);
        int i = 0;
        String[] attr = new String[11];
        String path = "G:\\个人\\IDEA_workspace\\Shopping\\web\\images\\";

        //1、创建一个DiskFileItemFactory工厂
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //2、创建一个文件上传解析器
        ServletFileUpload upload = new ServletFileUpload(factory);
        //解决上传文件名的中文乱码
        upload.setHeaderEncoding("UTF-8");
        upload.setSizeMax(1024 * 1024 * 50);//设置上传的文件总的大小不能超过50M
        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    attr[i] = item.getString("utf-8");
                    i++;
                }
                else {
                    String fileName = item.getName();
                    InputStream in = item.getInputStream();
                    byte[] buffer = new byte[1024];
                    int len = 0;
                    String[] name = fileName.split("\\\\");
                    fileName = path + name[name.length-1];//文件最终上传的位置
                    OutputStream out = new FileOutputStream(fileName);

                    while ((len = in.read(buffer)) != -1) {
                        out.write(buffer, 0, len);
                    }
                    out.close();
                    in.close();

                    UserOperations uo = new UserOperations();
                    if (uo.updateimg(uid, name[name.length-1])) {
                        response.sendRedirect("/jsp"+"/"+"showMessage.jsp");
                        return;
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);

    }
}
