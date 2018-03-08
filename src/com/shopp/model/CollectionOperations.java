package com.shopp.model;

import com.shopp.bean.Collection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CollectionOperations {
    private Connection ct=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
    /*
     * 构造方法
     */
    public CollectionOperations(){
        ct=Tools.getConnection();
    }
    /*
     * 添加收藏
     */
    public boolean addGoods(int uid, int gid, int number) throws Exception {
        ps = null;
        int result = 0;
        String message = this.getDesignateGoodsMs(uid, gid);
        if (!"".equals(message)) {
            int cid = Integer.valueOf(message.split("&")[0]);
            int goodsCount = Integer.valueOf(message.split("&")[1]);
            String sql = "update "+Tools.colle_table+" set number=?,date=now() where cid=?";
            ps = this.ct.prepareStatement(sql);
            ps.setInt(1, goodsCount + number);
            ps.setInt(2, cid);
        } else {
            String sql = "insert into "+Tools.colle_table+"(uid,gid,number,date)value(?,?,?,now());";
            ps = this.ct.prepareStatement(sql);
            ps.setInt(1, uid);
            ps.setInt(2, gid);
            ps.setInt(3, number);
        }
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }
    /*
     * 检查收藏中是否含有指定商品，如果没有则返回id和商品数量，否则返回空
     */
    public String getDesignateGoodsMs(int uid, int gid) throws Exception {
        rs = null;
        String sql = "select * from "+Tools.colle_table+" where uid =? and gid=?";
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, uid);
        ps.setInt(2, gid);
        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString("cid") + "&" + rs.getInt("number");
        }
        return "";
    }
    /*
     * 从收藏中删除商品
     */
    public boolean deleteGoods(int uid, int gid, int number) throws Exception {
        String message = this.getDesignateGoodsMs(uid, gid);
        int result = 0;
        if (!"".equals(message)) {
            int cid = Integer.valueOf(message.split("&")[0]);
            int goodsCount = Integer.valueOf(message.split("&")[1]);
            if (goodsCount < number) {
                return false;
            } else if (goodsCount == number) {
                String sql = "delete from "+Tools.colle_table+" where cid=?";
                ps = this.ct.prepareStatement(sql);
                ps.setInt(1, cid);
            } else {
                String sql = "update "+Tools.colle_table+" set number=? where cid=?";
                ps = this.ct.prepareStatement(sql);
                ps.setInt(1, goodsCount - number);
                ps.setInt(2, cid);
            }
            result = ps.executeUpdate();
            ps.close();
        }
        if (result == 1) {
            return true;
        }
        return false;
    }

    /*
     * 从收藏中删除商品
     */
    public boolean deleteGoodsByGid(int gid) throws Exception {
        String sql="delete from "+Tools.colle_table+" where gid="+gid+";";
        int result = 0;
        ps = ct.prepareStatement(sql);
        result = ps.executeUpdate();
        ps.close();

        if (result == 1) {
            return true;
        }
        return false;
    }
    /*
     * 获取收藏列表信息
     */
    public List<Collection> getAllGoods(int uid) throws Exception {
        ps = null;
        ResultSet rs = null;
        List<Collection> scList = null;
        String sql = "select * from "+Tools.colle_table+" where uid=?";
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, uid);
        rs = ps.executeQuery();
        Collection sc;
        scList = new ArrayList<Collection>();
        while (rs.next()) {
            sc = new Collection();
            sc.setCid(rs.getInt("cid"));
            sc.setUid(rs.getInt("uid"));
            sc.setGid(rs.getInt("gid"));
            sc.setNumber(rs.getInt("number"));
            String date = rs.getDate("date").toString();
            String time = rs.getTime("date").toString();
            sc.setDate(date + " " + time);
            scList.add(sc);
        }
        return scList;
    }

}
