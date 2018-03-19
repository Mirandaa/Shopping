package com.shopp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shopp.bean.User;
import com.shopp.md.Md5;

public class UserOperations {
    private Connection ct=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
    /*
     * 构造方法
     */
    public UserOperations() {
        ct=Tools.getConnection();
    }
    /*
     * 注册时添加用户
     */
    public boolean addUser(String name,String passwd,String email) {
        String sql="select * from "+Tools.user_table+" where phoneNum='"+email+"'";
        try {
            ps = ct.prepareStatement(sql);
            rs=ps.executeQuery();
            if(rs.next()){
                ct.close();
                return false;
            }
            else {
                sql="insert into users(uname,phoneNum,passwd,lastLogin)value(?,?,?,sysdate());";
                ps=ct.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, Md5.md5Encode(passwd));
                ps.executeUpdate();
                ct.close();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    /*
     * 登陆时检查用户
     */
    public boolean checkUser(String email,String passwd) {
        String sql="select * from "+Tools.user_table+" where phoneNum='"+email+"' and passwd='"+Md5.md5Encode(passwd)+"';";
        try {
            ps = ct.prepareStatement(sql);
            rs=ps.executeQuery();
            if(rs.next()){
                sql="update "+Tools.user_table+" set lastLogin=sysdate()"+"  where phoneNum='"+email+"';";
                ps=ct.prepareStatement(sql);
                ps.execute();//更新最后登陆时间
                return true;
            }
            else {
                ct.close();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    /*
     * 登陆时验证成功获取用户信息
     */
    public User getUser(String email){
        User user=new User();
        try {
            ps=ct.prepareStatement("select * from "+Tools.user_table+" where phoneNum='"+email+"';");
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                user.setUid(rs.getInt(1));
                user.setUname(rs.getString(2));
                user.setPasswd(rs.getString(4));
                user.setPhoneNum(rs.getString(3));
                user.setLastLogin(rs.getString(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    /*
     * 修改密码
     */
    public boolean editPasswd(int uid, String passwd) throws Exception {
        String sql = "update "+Tools.user_table+" set passwd=? where uid='" + uid+"'";
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, Md5.md5Encode(passwd));
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }

    public boolean editUname(int uid, String uname) throws Exception {
        String sql = "update "+Tools.user_table+" set uname=? where uid='" + uid+"'";
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, uname);
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }

    public User queryByPhoneNum(String phoneNum) throws Exception {
        User user = null;
        ResultSet rs = null;
        String sql = "select * from users where phoneNum =?";
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, phoneNum);
        rs = ps.executeQuery();
        while (rs.next()) {
            user = new User();
            int uid = rs.getInt("uid");
            String passwd = rs.getString("passwd");
            String uname = rs.getString("uname");
            user.setUid(uid);
            user.setUname(uname);
            user.setPasswd(passwd);
            user.setPhoneNum(phoneNum);
            String date = rs.getDate("lastlogin").toString();
            String time = rs.getTime("lastlogin").toString();
            user.setLastLogin(date + "　" + time);
        }
        ps.close();
        rs.close();
        return user;
    }

    public User queryByUid(String uid) throws Exception {
        User user = null;
        ResultSet rs = null;
        String sql = "select * from users where uid =?";
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, uid);
        rs = ps.executeQuery();
        while (rs.next()) {
            user = new User();
            String phoneNum = rs.getString("phoneNum");
            String passwd = rs.getString("passwd");
            String uname = rs.getString("uname");
            user.setUid(Integer.parseInt(uid));
            user.setUname(uname);
            user.setPasswd(passwd);
            user.setPhoneNum(phoneNum);
            String date = rs.getDate("lastlogin").toString();
            String time = rs.getTime("lastlogin").toString();
            user.setLastLogin(date + "　" + time);
        }
        ps.close();
        rs.close();
        return user;
    }
    /*
     * 找回密码
     */
    public boolean findPasswd(String phoneNum, String passwd) throws Exception {
        String sql = "update "+Tools.user_table+" set passwd=? where phoneNum='" + phoneNum+"'";
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, Md5.md5Encode(passwd));
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }
}
