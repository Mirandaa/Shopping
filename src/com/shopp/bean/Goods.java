package com.shopp.bean;

/**
 * 商品信息
 */
public class Goods {

    // 主键
    private int gid;
    // 商品名
    private String gname;
    // 现有商品数量
    private int number;
    // 商品照片
    private String photo;
    // 商品类型
    private String type;
    // 生产商
    private String producer;
    // 价格
    private float price;
    // 运费
    private float carriage;
    // 生产日期
    private String pdate;
    // 生产地址
    private String paddress;
    // 商品描叙
    private String described;
    //上传者Id
    private int uid;
    //上传时间
    private String udate;

    public Goods() {

    }

    @Override
    public String toString() {
        return "Goods{" +
                "gid=" + gid +
                ", gname='" + gname + '\'' +
                ", number=" + number +
                ", photo='" + photo + '\'' +
                ", type='" + type + '\'' +
                ", producer='" + producer + '\'' +
                ", price=" + price +
                ", carriage=" + carriage +
                ", pdate='" + pdate + '\'' +
                ", paddress='" + paddress + '\'' +
                ", described='" + described + '\'' +
                ", uid=" + uid +
                ", udate='" + udate + '\'' +
                '}';
    }

    public Goods(String gname, int number, String photo, String type,
                 String producer, float price, float carriage, String pdate,
                 String paddress, String described, int uid, String udate) {
        this.gname = gname;
        this.number = number;
        this.photo = photo;
        this.type = type;
        this.producer = producer;
        this.price = price;
        this.carriage = carriage;
        this.pdate = pdate;
        this.paddress = paddress;
        this.described = described;
        this.uid=uid;
        this.udate=udate;
    }
    public Goods(int gid, String gname, int number, String photo, String type,
                 String producer, float price, float carriage, String pdate,
                 String paddress, String described, int uid, String udate) {
        this.gid = gid;
        this.gname = gname;
        this.number = number;
        this.photo = photo;
        this.type = type;
        this.producer = producer;
        this.price = price;
        this.carriage = carriage;
        this.pdate = pdate;
        this.paddress = paddress;
        this.described = described;
        this.uid=uid;
        this.udate=udate;
    }
    /*不传photo进去*/
    public int getGid() {
        return gid;
    }

    public void setGid(int gid) {
        this.gid = gid;
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getCarriage() {
        return carriage;
    }

    public void setCarriage(float carriage) {
        this.carriage = carriage;
    }

    public String getPdate() {
        return pdate;
    }

    public void setPdate(String pdate) {
        this.pdate = pdate;
    }

    public String getPaddress() {
        return paddress;
    }

    public void setPaddress(String paddress) {
        this.paddress = paddress;
    }

    public String getDescribed() {
        return described;
    }

    public void setDescribed(String described) {
        this.described = described;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getudate() {
        return udate;
    }

    public void setudate(String udate) {
        this.udate = udate;
    }

}
