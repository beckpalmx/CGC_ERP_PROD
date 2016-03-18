/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;
import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

/**
 *
 * @author beck
 */
public class Upload_Image {
    private int status;

    /**
     *
     * @param request
     * @throws Exception
     */
    
    public Upload_Image(HttpServletRequest request)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        Random r = new  Random();
        MultipartFormDataRequest mul = new MultipartFormDataRequest(request);
        UploadBean uploadBean = new UploadBean();
        PreparedStatement p = null;
        String value_pass = "";
        String caseform_pass = "";
        try{
            UploadFile uploadFile = (UploadFile) mul.getFiles().get("file_upload");
            System.out.println("uploadFile.getFileName() = " + uploadFile.getFileName());
            uploadFile.setFileName(uploadFile.getFileName().replace(".jpg", "_") +Long.toString(Math.abs(r.nextLong()),36)+new SimpleDateFormat("ddMMyy_hhmmssS").format(new Date())+".jpg");
            uploadBean.setFolderstore((new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("UPLOADS/")))).append("/").toString());
            caseform_pass = mul.getParameter("caseform");
            if (caseform_pass.equalsIgnoreCase("1")){
                value_pass = mul.getParameter("part_id");
            } else if (caseform_pass.equalsIgnoreCase("2")){
                value_pass = mul.getParameter("machine_id");
            } 
            System.out.println("Case Form = "+mul.getParameter("caseform"));
            System.out.println("Case Form PASS= "+caseform_pass);
            System.out.println(value_pass);                
            update(value_pass, uploadFile.getFileName(), p, con,caseform_pass);
            uploadBean.store(mul);
        }catch(Exception e){
            e.printStackTrace(System.out);
            status = -1;
        }finally{
            if(p != null){
                p.close();
            }
            con.close();
            status = 1;
        }
    }
    private void update(String value_pass,String upload_file_name,PreparedStatement p,Connection con,String caseform_pass_value)throws Exception{
        try{            
            if (caseform_pass_value.equalsIgnoreCase("1")){
                p = con.prepareStatement("update m_part set pic1=? where part_id = '"+value_pass+"' and delete_flag = 'N'");
            } else if (caseform_pass_value.equalsIgnoreCase("2")){
                p = con.prepareStatement("update m_machine set pic1=? where machine_id = '"+value_pass+"' and delete_flag = 'N'");
            }            
            
            System.out.println("p = " + p);
            
            p.setString(1, upload_file_name);
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            p = null;
        }
    }

    /**
     *
     * @return
     */
    public int Return_Status(){
        return status;
    }
}
