package com.shopp.md;

import java.security.MessageDigest;

public class Md5 {
    /**
     * 将byte数组转换成十六进制输出
     */
    public static String convertByteToHexString(byte[] bytes) {
        String result = "";
        for (int i = 0; i < bytes.length; i++) {
            int temp = bytes[i] & 0xff;
            String tempHex = Integer.toHexString(temp);
            if (tempHex.length() < 2) {
                result += "0" + tempHex;
            } else {
                result += tempHex;
            }
        }
        return result;
    }

    /**
     * jdk自带的MD5加密
     */
    public static String md5Encode(String message) {
        String temp = "";

        try {
            MessageDigest md5Digest = MessageDigest.getInstance("MD5");
            byte[] encodeMd5Digest = md5Digest.digest(message.getBytes());
            temp = convertByteToHexString(encodeMd5Digest);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return temp;
    }

}
