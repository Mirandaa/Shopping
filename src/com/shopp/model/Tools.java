package com.shopp.model;

import java.sql.Connection;
import java.sql.DriverManager;

public class Tools {
    public static String user_table="users";
    public static String goods_table="goods";
    public static String colle_table="collection";
    public static Connection getConnection() {
        Connection connection=null;
        String url="jdbc:mysql://localhost:3306/shopping?useUnicode=true&characterEncoding=utf8";
        String name="root";
        String pass="123456";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            connection=DriverManager.getConnection(url, name, pass);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return connection;
    }//获取数据库连接
}


