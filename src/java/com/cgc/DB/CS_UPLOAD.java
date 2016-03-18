/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.bean.DataBean_Upload;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadFile;
import javazoom.upload.UploadBean;

/**
 *
 * @author Administrator
 */
public class CS_UPLOAD {

    private static String directory_id;
    private static String directory_parth;

    public String Image_Upload(HttpServletRequest request) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        Random r = new Random();
        String token = "";
        MultipartFormDataRequest mul = new MultipartFormDataRequest(request);
        ArrayList<UploadFile> objal = new ArrayList<UploadFile>();
        UploadBean uploadBean = new UploadBean();
        Result_Directory(con);
        //JOptionPane.showConfirmDialog(null, request.getParameter("pic_name"));
        try {
            objal.add((UploadFile) mul.getFiles().get("files[]"));
            for (int i = 0; i < objal.size(); i++) {
                token = Long.toString(Math.abs(r.nextLong()), 36) + new SimpleDateFormat("ddMMyy_hhmmssS").format(new Date());
                objal.get(i).setFileName(token + ".jpg");
            }
            //JOptionPane.showConfirmDialog(null, request.getParameter("pic_name"));
            Insert(objal,new ThaiUtil().EncodeTexttoTIS(mul.getParameter("pic_name")), con);
            uploadBean.setFolderstore(directory_parth);
            uploadBean.store(mul);

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (con != null) {
                con.close();
            }
            if(!objal.isEmpty()){
                objal.clear();
            }
            return "ทำการ Upload สำเร็จ<br>";
        }
    }

    private static void Result_Directory(Connection con) throws Exception {
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(
                    "SELECT  directory_id,(driv_name||parth_name ):: character varying as directory_parth   from m_directory where directory_id  = '0001'");
            while (rs.next()) {
                directory_id = rs.getString("directory_id");
                directory_parth = rs.getString("directory_parth");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
    }

    public void Insert(ArrayList<UploadFile> objal,String name_t, Connection con) throws Exception {
        PreparedStatement p = null;
        try {
            if (!objal.isEmpty()) {
                p = con.prepareStatement(
                        "INSERT into m_picture"
                        + "(picture_id,directory_id,name_t) "
                        + "VALUES"
                        + "(?,?,?)");
                for (int i = 0; i < objal.size(); i++) {
                    p.setString(1, objal.get(i).getFileName());
                    p.setString(2, directory_id);
                    p.setString(3,name_t);
                    p.addBatch();
                }
                p.executeBatch();
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }

    public String ShowPicture() throws Exception {
        StringBuffer return_string = new StringBuffer();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(
                    "select m_picture.runno,"
                    + "(select m_directory.remark:: character varying    from m_directory where m_directory.directory_id  = m_picture.directory_id)||'/'||picture_id as scr "
                    + "from m_picture where delete_flag = 'N' order by m_picture.runno");
            return_string.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
            while (rs.next()) {
                return_string.append("<tr>");
                return_string.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\" value = '" + rs.getString("runno") + "'></td>");
                return_string.append("<td class='forborder' width='7%'>" + rs.getString("runno") + "</td>");
                return_string.append("<td class='forborder' width='30%'><input name='param" + rs.getString("runno") + "' type='text' id='param" + rs.getString("runno") + "' value='" + rs.getString("runno") + "' size=20 readonly='readonly' /></td>");
                //return_string.append("<td class='forborder' width='25%'><input name='param" + rs.getString("runno") + "' type='text' id='param" + rs.getString("runno") + "' value='" + rs.getString("runno") + "' size=20 readonly='readonly' /></td>");
                return_string.append("<td class='forborder' width='60%'><img src='" + rs.getString("scr") + "'  name='IMAGE1' width='100' height='100' border='0' align='middle' ></td>");
                //return_string.append("<img src='"+rs.getString("scr")+"'  name='IMAGE1' width='20' height='20' border='0' align='middle' ><br>");
                return_string.append("</tr>");
            }
            return_string.append("</table>");
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            return return_string.toString();
        }
    }
    //========================ลบรูปภาพ=======================================

    public void Delete_File(String input) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        ArrayList<DataBean_Upload> objAL_Delete = new ArrayList<DataBean_Upload>();
        objAL_Delete = Result_Deletefile(input, con);
        //Result_Directory(con);
        try {
            for (int i = 0; i < objAL_Delete.size(); i++) {
                File fl = new File(objAL_Delete.get(i).getParth());
                fl.delete();
            }
        } catch (Exception e) {
        } finally {
            if (con != null) {
                con.close();
            }
            if (!objAL_Delete.isEmpty()) {
                objAL_Delete.clone();
            }
        }
    }
    //=====================================================================

    //===================ค้นหารูปภาพที่จะลบ====================================
    private static ArrayList<DataBean_Upload> Result_Deletefile(String index, Connection con) throws Exception {
        ArrayList<DataBean_Upload> objal = new ArrayList<DataBean_Upload>();
        ResultSet rs = null;
        //PreparedStatement p = null;
        try {
            rs = con.createStatement().executeQuery(
                    "select m_picture.runno,((select m_directory.driv_name||m_directory.parth_name from m_directory where m_directory.directory_id = m_picture.directory_id)||'\\\\'||m_picture.picture_id)as parth_delete from m_picture  where runno in (" + index + ") and delete_flag = 'N'");
            while (rs.next()) {
                DataBean_Upload objbean = new DataBean_Upload();
                objbean.setRunno(rs.getInt("runno"));
                objbean.setParth(rs.getString("parth_delete"));
                objal.add(objbean);
            }
            rs = null;
            con.createStatement().executeUpdate("update m_picture set delete_flag = 'Y' where runno in (" + index + ")");
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            return objal;
        }
    }
    //=====================================================================
}
