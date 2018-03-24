package com.shopp.control;

import com.shopp.bean.Goods;
import com.shopp.model.GoodsOperations;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class UploadServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        int p = 0;
        int i = 0;
        String[] attr = new String[11];
        String path = "G:\\个人\\IDEA_workspace\\Shopping\\web\\images\\";
        int uid=0;

        //1、创建一个DiskFileItemFactory工厂
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //2、创建一个文件上传解析器
        ServletFileUpload upload = new ServletFileUpload(factory);
        //解决上传文件名的中文乱码
        upload.setHeaderEncoding("UTF-8");
        upload.setSizeMax(1024 * 1024 * 50);//设置上传的文件总的大小不能超过50M
        try {
            // 1. 得到 FileItem 的集合 items
            List<FileItem> /* FileItem */items = upload.parseRequest(request);

            // 2. 遍历 items:
            for (FileItem item : items) {
                if (item.isFormField()) {
                    attr[i] = item.getString("utf-8");
                    i++;
                }
                else {
                    p++;
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

                    //修改文件名
                    String newname = attr[0] +  String.valueOf(p) + ".jpg";
                    if(!name[name.length-1].equals(newname)){//新的文件名和以前文件名不同时,才有必要进行重命名
                        File oldfile = new File(fileName);
                        File newfile = new File(path+newname);
                        if(!oldfile.exists()){
                            return;//重命名文件不存在
                        }
                        if(newfile.exists())//若在该目录下已经有一个文件和新文件名相同，则不允许重命名
                            System.out.println(newname+"已经存在！");
                        else{
                            oldfile.renameTo(newfile);
                        }
                    }else{
                        System.out.println("新文件名和旧文件名相同...");
                    }
                }
            }
        }catch (Exception e){
            System.out.print("上传失败");
            e.printStackTrace();
        }

        try{
            String strUid =request.getSession().getAttribute("uid").toString();

            if(strUid!=null){
                uid = Integer.parseInt(strUid);
            }

            String gname = attr[0];
            int number = Integer.parseInt(attr[1]);
            String types = attr[2];
            String producer = attr[5];
            float price = Float.parseFloat(attr[3]);
            float carriage = Float.parseFloat(attr[4]);
            String paddress = attr[6];
            String described = attr[7];
            String gphoto = gname+"1.jpg&"+gname+"2.jpg&"+gname+"3.jpg";
            Date date=new Date();
            DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String udate=format.format(date);

            GoodsOperations go = new GoodsOperations();
            Goods goods = new Goods(gname, number, gphoto, types,
                    producer, price, carriage, "2017-06-27", paddress, described, uid, udate);
            boolean flag = false;
            try {
                flag = go.addGoods(goods);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag) {
                System.out.print("success");
                response.sendRedirect("index.jsp");
            } else {
                System.out.print("success");
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {

            e.printStackTrace();
            response.sendRedirect("jsp/login.jsp");
        }
    }

}
