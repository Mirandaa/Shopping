package com.shopp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopp.bean.Goods;
import com.mysql.jdbc.Statement;

public class GoodsOperations {
    private Connection ct=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
    /*
     * 构造方法
     */
    public GoodsOperations() {
        ct=Tools.getConnection();
    }
    /*
     * 获取所有商品信息
     */
    public List<Goods> getAllGoods() throws Exception{
        List<Goods> glist=new ArrayList<Goods>();
        Goods goods=null;
        ps=ct.prepareStatement("select * from "+Tools.goods_table+" order by gid desc;");
        rs=ps.executeQuery();
        while(rs.next()){
            int gid = rs.getInt("gid");
            String gname = rs.getString("gname");
            int number = rs.getInt("number");
            String photo = rs.getString("gphoto");
            String type = rs.getString("types");
            String producer = rs.getString("producer");
            float price = rs.getFloat("price");
            float carriage = rs.getFloat("carriage");
            String pdate = rs.getDate("pdate").toString();
            String paddress = rs.getString("paddress");
            String described = rs.getString("described");
            int uid=rs.getInt("uid");
            String udate=rs.getString("udate");
            goods = new Goods(gname, number, photo, type, producer, price,
                    carriage, pdate, paddress, described, uid,udate);
            goods.setGid(gid);
            goods.setUid(uid);
            glist.add(goods);
        }
        return glist;
    }
    /*
     * 添加商品
     */
    public boolean addGoods(Goods goods) throws Exception {
        ps = null;
        String sql = "insert into "+Tools.goods_table+"(gname,gphoto,types,producer,price,carriage,pdate,paddress,described,number,uid,udate)value(?,?,?,?,?,?,?,?,?,?,?,?);";
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, goods.getGname());
        ps.setString(2, goods.getPhoto());
        ps.setString(3, goods.getType());
        ps.setString(4, goods.getProducer());
        ps.setFloat(5, goods.getPrice());
        ps.setFloat(6, goods.getCarriage());
        ps.setString(7, goods.getPdate());
        ps.setString(8, goods.getPaddress());
        ps.setString(9, goods.getDescribed());
        ps.setInt(10, goods.getNumber());
        ps.setInt(11, goods.getUid());
        ps.setString(12, goods.getudate());
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }
    /*
     * 编辑商品
     */
    public boolean editInfo(Goods goods) throws Exception {
        ps = null;
        String sql = "update "+Tools.goods_table+" set gname=?,gphoto=?,types=?,producer=?,price=?,carriage=?,pdate=?,paddress=?,described=?,number=? where gid="
                + goods.getGid();
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, goods.getGname());
        ps.setString(2, goods.getPhoto());
        ps.setString(3, goods.getType());
        ps.setString(4, goods.getProducer());
        ps.setFloat(5, goods.getPrice());
        ps.setFloat(6, goods.getCarriage());
        ps.setString(7, goods.getPdate());
        ps.setString(8, goods.getPaddress());
        ps.setString(9, goods.getDescribed());
        ps.setInt(10, goods.getNumber());
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }
    /*
     * 删除商品
     */
    public boolean deleteGoods(int gid) throws Exception {
        String sql = "delete from "+Tools.goods_table+" where gid=?";
        int result = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, gid);
        result = ps.executeUpdate();
        ps.close();
        if (result == 1) {
            return true;
        }
        return false;
    }
    /*
     * 根据id查找商品
     */
    public Goods queryById(int gid) throws Exception {
        Goods goods = null;
        String sql = "select * from "+Tools.goods_table+" where gid =?";
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, gid);
        rs = ps.executeQuery();
        while (rs.next()) {
            goods = new Goods();
            goods.setGid(rs.getInt("gid"));
            goods.setGname(rs.getString("gname"));
            goods.setNumber(rs.getInt("number"));
            goods.setPhoto(rs.getString("gphoto"));
            goods.setType(rs.getString("types"));
            goods.setProducer(rs.getString("producer"));
            goods.setPrice(rs.getFloat("price"));
            goods.setCarriage(rs.getFloat("carriage"));
            goods.setPdate(rs.getString("pdate"));
            goods.setPaddress(rs.getString("paddress"));
            goods.setDescribed(rs.getString("described"));
        }
        ps.close();
        rs.close();
        return goods;
    }
    /*
     * 根据id返回商品数量
     */
    public int queryNumberById(int gid) throws Exception {
        String sql = "select number from "+Tools.goods_table+" where gid =?";
        int number = 0;
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, gid);
        rs = ps.executeQuery();
        if (rs.next()) {
            number = rs.getInt("number");
        }
        ps.close();
        rs.close();
        return number;
    }
    /*
     * 获取最新的4个商品
     */
    public List<Goods> getLatestGoods(int gid, String type) throws Exception {
        List<Goods> goodsList = new ArrayList<Goods>();
        Goods goods;
        String sql = "select gid,gname,price from "+Tools.goods_table+" where gid != ? and types=? order by gid desc limit 4";
        ps = this.ct.prepareStatement(sql);
        ps.setInt(1, gid);
        ps.setString(2, type);
        rs = ps.executeQuery();
        while (rs.next()) {
            goods = new Goods();
            goods.setGid(rs.getInt("gid"));
            goods.setGname(rs.getString("gname"));
            goods.setPrice(rs.getFloat("price"));
            goodsList.add(goods);
        }
        return goodsList;
    }
    /*
     * 查询类型
     */
    public String[] queryTypes() throws Exception {
        String sql = "select distinct types from "+Tools.goods_table+"";
        Statement st = null;
        st = (Statement) ct.createStatement();
        rs = st.executeQuery(sql);
        String[] types = new String[10];
        int i = 0;
        while (rs.next()) {
            types[i] = rs.getString("types");
            i++;
        }
        return types;
    }
    /*
     * 得到相应type的商品列表
     */
    public List<Goods> getTypeGoodsList(String type) throws Exception {
        List<Goods> goodsList = new ArrayList<Goods>();
        Goods goods;
        String sql = "select gid,gname from "+Tools.goods_table+" where types=? order by gid desc;";
        ps = this.ct.prepareStatement(sql);
        ps.setString(1, type);
        rs = ps.executeQuery();
        while (rs.next()) {
            goods = new Goods();
            goods.setGid(rs.getInt("gid"));
            goods.setGname(rs.getString("gname"));
            goodsList.add(goods);
        }
        return goodsList;
    }
    /*
     *
     */
    public List<Goods> getGoodsListByUid(int uid) throws Exception {
        List<Goods> glist=new ArrayList<Goods>();
        Goods goods=null;
        ps=ct.prepareStatement("select * from "+Tools.goods_table+" where uid="+uid+" order by gid;");
        rs=ps.executeQuery();
        while(rs.next()){
            int gid = rs.getInt("gid");
            String gname = rs.getString("gname");
            int number = rs.getInt("number");
            String photo = rs.getString("gphoto");
            String type = rs.getString("types");
            String producer = rs.getString("producer");
            float price = rs.getFloat("price");
            float carriage = rs.getFloat("carriage");
            String pdate = rs.getDate("pdate").toString();
            String paddress = rs.getString("paddress");
            String described = rs.getString("described");
            String udate=rs.getString("udate");
            goods = new Goods(gname, number, photo, type, producer, price,
                    carriage, pdate, paddress, described,uid,udate);
            goods.setGid(gid);
            goods.setUid(uid);
            glist.add(goods);
        }
        return glist;
    }

    /*
     * 根据gid返回用户联系方式
     */
    public String getPhoneNumByGid(int gid) throws Exception {
        String sql = "select phoneNum from users,goods where gid="+gid+" and users.uid=goods.uid;";
        String phoneNum = null;
        ps = this.ct.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            phoneNum = rs.getString("phoneNum");
        }
        ps.close();
        rs.close();
        return phoneNum;
    }
/*
*根据关键字查询商品
 */
    public List<Goods> getGoodsListByKeyValue(String value,int order) throws Exception {
        List<Goods> glist=new ArrayList<Goods>();
        Goods goods=null;
        if(order == 0){
            ps=ct.prepareStatement("select * from "+Tools.goods_table+" where described LIKE '%"+value+"%'or types LIKE '%\"+value+\"%' or gname LIKE '%\"+value+\"%' order by pdate ;");
        }else{
            ps=ct.prepareStatement("select * from "+Tools.goods_table+" where described LIKE '%"+value+"%' or types LIKE '%\"+value+\"%' or gname LIKE '%\"+value+\"%' order by price ;");
        }
        rs=ps.executeQuery();
        while(rs.next()){
            int gid = rs.getInt("gid");
            String gname = rs.getString("gname");
            int number = rs.getInt("number");
            String photo = rs.getString("gphoto");
            String type = rs.getString("types");
            String producer = rs.getString("producer");
            float price = rs.getFloat("price");
            float carriage = rs.getFloat("carriage");
            String pdate = rs.getDate("pdate").toString();
            String paddress = rs.getString("paddress");
            String described = rs.getString("described");
            String udate=rs.getString("udate");
            int uid=rs.getInt("uid");
            goods = new Goods(gname, number, photo, type, producer, price,
                    carriage, pdate, paddress, described,uid,udate);
            goods.setGid(gid);
            goods.setUid(uid);
            glist.add(goods);
        }
        return glist;
    }
}
