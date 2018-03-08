package com.shopp.bean;

/**
 * Created by Maggie on 2018/3/6.
 */
public class Collection {

    // 主键
    private int cid;
    // 用户id
    private int uid;
    // 商品id
    private int gid;
    // 收藏商品数量
    private int number;
    // 收藏的时间
    private String date;

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getGid() {
        return gid;
    }

    public void setGid(int gid) {
        this.gid = gid;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }


}
