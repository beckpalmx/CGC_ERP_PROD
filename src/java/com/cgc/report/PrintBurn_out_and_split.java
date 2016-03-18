/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_burn_out_and_split;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Beck
 */
public class PrintBurn_out_and_split {
    //static DataBean_burn_out_and_split bean = new DataBean_burn_out_and_split();

    public void ReportBurn_out_and_split(HttpServletRequest request, HttpServletResponse response) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String[] doc_id_run = request.getParameter("doc_id_run").split(",");
        String burn_no = request.getParameter("burn_no");
        String c_type = request.getParameter("product_id");
        System.out.println("c_type = "+c_type);
        String chenal = request.getParameter("ch_from") + "-" +request.getParameter("ch_to");
        ArrayList<DataBean_burn_out_and_split> AL_Print = new ArrayList<DataBean_burn_out_and_split>();
        try {
            for(int i = 0;i< doc_id_run.length;i++){
                AL_Print = Select_Data_burn_out_and_split(con, AL_Print, doc_id_run[i], burn_no, c_type);
            }
            Write(AL_Print, response,"เตา "+burn_no+" ช่อง "+chenal);
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            AL_Print.clear();
            if(con != null){
                con.close();
            }
        }
    }

    public void Write(ArrayList<DataBean_burn_out_and_split> AL_Print, HttpServletResponse response,String Title) throws IOException {
        String[] Cell_Name = new String[]{"B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y"};
        String str = "";
        UtiDatabase objuti = new UtiDatabase();
        response.setContentType("application/csv");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
        response.setBufferSize(1024);
        PrintWriter pw = response.getWriter();
        try{
        pw.println("รหัส,ถ่านออกจากเตาN,ถ่านออกจากเตาS,ถ่านออกจากเตาA,N +4,N 4x8,N 8x30,S +4,S 4x8,S 8x30,A +4,A 4x8,A 8x30,N -30, S -30,A -30,N ฝุ่น,S ฝุ่น,A ฝุ่น,N หิน,S หิน,A หิน,Nยอดสูญเสีย,Sยอดสูญเสีย,Aยอดสูญเสีย");
        for (int i = 0; i < AL_Print.size(); i++) {
            str = "";
            str = objuti.NotNull(AL_Print.get(i).getDoc_id()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_out_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_out_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_out_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_Plus4_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_4_8_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_8_30_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_Plus4_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_4_8_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_8_30_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_Plus4_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_4_8_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_8_30_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_negative30_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_negative30_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getCarbon_negative30_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getDust_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getDust_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getDust_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getStone_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getStone_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getStone_A()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getLost_N()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getLost_S()) + ",";
            str += objuti.NotNull(AL_Print.get(i).getLost_A());
            pw.println(str);
        }
        
        pw.println("น.น รวม," + Sum_Formula(Cell_Name,Integer.toString(AL_Print.size()+1)));
        pw.println("%," + Persent_Formula(Cell_Name,Integer.toString(AL_Print.size()+2))+Persent_Formula2(Cell_Name,Integer.toString(AL_Print.size()+2)));
        pw.println("ยอดรวม,ถ่านออกจากเตา,กะN,กะS,กะA,-30,ฝุ่น,หิน,ยอดสูญเสีย,'+4,4x8,8x30,");
        pw.println("," + Sum_Total(Cell_Name,Integer.toString(AL_Print.size()+2))+Sum_Size_Formula(Cell_Name,Integer.toString(AL_Print.size()+2)));
        pw.println("ค่าเฉลี่ย,-30,ฝุ่น,หิน,ยอดสูญเสีย");
        pw.println("," + Avg_Formula(Cell_Name,Integer.toString(AL_Print.size()+3)));
        pw.println("%,'+4,4x8,8x30,");
        pw.println(","+Persent_Formula3(Cell_Name,Integer.toString(AL_Print.size()+5)));
        pw.println("");
        pw.println("รายงานถ่านออกจากเตาและร่อนแยก,"+Title);
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(pw != null){
                pw.close();
            }
        }
    }

    public String Sum_Formula(String[] Cell_Name,String Cell_Number) {
        String str_math = "";
        for (int i = 0; i < Cell_Name.length; i++) {
            str_math += "=SUM(" + Cell_Name[i] + "2 : " + Cell_Name[i] + Cell_Number+")" + ",";
        }
        return str_math;
    }

    public String Sum_Total(String[] Cell_Name,String Cell_Number) {
        String str_math = "";
        int count = 0;
        while (count < Cell_Name.length) {
            str_math += "=" + Cell_Name[count] + Cell_Number+"+" + Cell_Name[count + 1] + Cell_Number+"+" + Cell_Name[count + 2] + Cell_Number+",";
            count += 3;
        }
        return str_math;

    }

    public String Persent_Formula(String[] Cell_Name,String Cell_Number) {
        int count = 0;
        String str_math = "";
        while (count < 12) {
            str_math += "=" + Cell_Name[count] + Cell_Number+"/((" + Cell_Name[count] + Cell_Number+"+" + Cell_Name[count + 1] + Cell_Number+"+" + Cell_Name[count + 2] +Cell_Number+")/100),";
            str_math += "=" + Cell_Name[count + 1] + Cell_Number+"/((" + Cell_Name[count] +Cell_Number+"+" + Cell_Name[count + 1] + Cell_Number+"+" + Cell_Name[count + 2] + Cell_Number+")/100),";
            str_math += "=" + Cell_Name[count + 2] + Cell_Number+"/((" + Cell_Name[count] + Cell_Number+"+" + Cell_Name[count + 1] + Cell_Number+"+" + Cell_Name[count + 2] + Cell_Number+")/100),";
            count += 3;
        }
        return str_math;
    }
    public String Persent_Formula2(String[] Cell_Name,String Cell_Number) {
        int count = 12,count2 = 0;
        String str_math = "";
        while (count < Cell_Name.length) {
            str_math += "=(" + Cell_Name[count] + Cell_Number+"*100)/"+Cell_Name[count2]+Cell_Number+",";
            str_math += "=(" + Cell_Name[count+1] + Cell_Number+"*100)/"+Cell_Name[count2+1]+Cell_Number+",";
            str_math += "=(" + Cell_Name[count+2] + Cell_Number+"*100)/"+Cell_Name[count2+2]+Cell_Number+",";
            count += 3;
        }
        return str_math;
    }
    public String Persent_Formula3(String[] Cell_Name,String Cell_Number) {
        int count = 8;
        String str_math = "";
        for(int i = 0;i<3;i++) {
            str_math += "=(" + Cell_Name[count] + Cell_Number+"*100)/"+Cell_Name[0]+Cell_Number+",";
            count += 1;
        }
        return str_math;
    }

    public String Avg_Formula(String[] Cell_Name,String Cell_Number) {
        String str_math = "";
        int count = 12;
        while (count < Cell_Name.length) {
            str_math += "=(" + Cell_Name[count] + Cell_Number+"+" + Cell_Name[count + 1] + Cell_Number+"+" + Cell_Name[count + 2] + Cell_Number+")/3,";
            count += 3;
        }
        return str_math;
    }
    public String Sum_Size_Formula(String[] Cell_Name,String Cell_Number){
        String str_math = "";
        int count = 3;
        for(int i = 0;i < 3;i++){
            str_math += "=(" + Cell_Name[count] + Cell_Number+"+" + Cell_Name[count + 3] + Cell_Number+"+" + Cell_Name[count + 6] + Cell_Number+"),";
            count += 1;
        }
        return str_math;
    }
    public ArrayList<DataBean_burn_out_and_split> Select_Data_burn_out_and_split(Connection con, ArrayList<DataBean_burn_out_and_split> AL_Obj, String str_doc_id,String Burn_no,String C_type)throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String doc_id_A = Format_Date_to_Doc_ID(str_doc_id, "A", Burn_no, C_type);
        String doc_id_N = Format_Date_to_Doc_ID(str_doc_id, "N", Burn_no, C_type);
        String doc_id_S = Format_Date_to_Doc_ID(str_doc_id, "S", Burn_no, C_type);
        String SQL_header = "select doc_id,weight_split,lost_weight from d_carbon_burn_out_header where delete_flag = 'N' and doc_id = '"+doc_id_A+"' or doc_id = '"+doc_id_N+"' or doc_id = '"+doc_id_S+"'";
        String SQL_detail = "Select line_no,doc_id,production_no,size,weight,shift from d_carbon_burn_out_detail  where delete_flag = 'N' and doc_id = '"+doc_id_A+"' or doc_id = '"+doc_id_N+"' or doc_id = '"+doc_id_S+"'";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL_header);
            DataBean_burn_out_and_split bean_header = new  DataBean_burn_out_and_split();
            while(rs.next()){
                bean_header.setDoc_id(str_doc_id);
                if(rs.getString("doc_id").indexOf("A") != -1){
                     bean_header.setCarbon_out_A(rs.getString("weight_split"));
                     bean_header.setLost_A(rs.getString("lost_weight"));
                }else if(rs.getString("doc_id").indexOf("N") != -1){
                     bean_header.setCarbon_out_N(rs.getString("weight_split"));
                     bean_header.setLost_N(rs.getString("lost_weight"));
                }else{
                    bean_header.setCarbon_out_S(rs.getString("weight_split"));
                     bean_header.setLost_S(rs.getString("lost_weight"));
                }
            }
            rs = null;
            rs = con.createStatement().executeQuery(SQL_detail);
            while(rs.next()){
                bean_header.setProduction_no(rs.getString("production_no").substring(0, 6));
                if(rs.getString("doc_id").indexOf("A") != -1){
                    if(rs.getString("size").equals("+4")){
                        bean_header.setCarbon_Plus4_A(rs.getString("weight"));
                    }else if(rs.getString("size").equals("4x8")){
                        bean_header.setCarbon_4_8_A(rs.getString("weight"));
                    }else if(rs.getString("size").equals("8x30")){
                        bean_header.setCarbon_8_30_A(rs.getString("weight"));
                    }else if(rs.getString("size").equals("-30")){
                        bean_header.setCarbon_negative30_A(rs.getString("weight"));
                    }else if(rs.getString("size").equals("ฝุ่น")){
                        bean_header.setDust_A(rs.getString("weight"));
                    }else if(rs.getString("size").equals("หิน")){
                        bean_header.setStone_A(rs.getString("weight"));
                    }
                }else if(rs.getString("doc_id").indexOf("N") != -1){
                    if(rs.getString("size").equals("+4")){
                        bean_header.setCarbon_Plus4_N(rs.getString("weight"));
                    }else if(rs.getString("size").equals("4x8")){
                        bean_header.setCarbon_4_8_N(rs.getString("weight"));
                    }else if(rs.getString("size").equals("8x30")){
                        bean_header.setCarbon_8_30_N(rs.getString("weight"));
                    }else if(rs.getString("size").equals("-30")){
                        bean_header.setCarbon_negative30_N(rs.getString("weight"));
                    }else if(rs.getString("size").equals("ฝุ่น")){
                        bean_header.setDust_N(rs.getString("weight"));
                    }else if(rs.getString("size").equals("หิน")){
                        bean_header.setStone_N(rs.getString("weight"));
                    }
                }else{
                   if(rs.getString("size").equals("+4")){
                        bean_header.setCarbon_Plus4_S(rs.getString("weight"));
                    }else if(rs.getString("size").equals("4x8")){
                        bean_header.setCarbon_4_8_S(rs.getString("weight"));
                    }else if(rs.getString("size").equals("8x30")){
                        bean_header.setCarbon_8_30_S(rs.getString("weight"));
                    }else if(rs.getString("size").equals("-30")){
                        bean_header.setCarbon_negative30_S(rs.getString("weight"));
                    }else if(rs.getString("size").equals("ฝุ่น")){
                        bean_header.setDust_S(rs.getString("weight"));
                    }else if(rs.getString("size").equals("หิน")){
                        bean_header.setStone_S(rs.getString("weight"));
                    }
                }
            }

            if(AL_Obj.isEmpty()){
                for(int i = 1 ; i<= 2;i++){
                    DataBean_burn_out_and_split Mem_AL = new DataBean_burn_out_and_split();
                    if(i==1){
                        Mem_AL.setDoc_id(bean_header.getDoc_id());
                        Mem_AL.setCarbon_out_A(bean_header.getCarbon_out_A());
                        Mem_AL.setCarbon_out_N(bean_header.getCarbon_out_N());
                        Mem_AL.setCarbon_out_S(bean_header.getCarbon_out_S());
                        AL_Obj.add(Mem_AL);
                    }else{
                        Mem_AL.setProduction_no(bean_header.getProduction_no());
                        ///------------------------A----------------------------
                       Mem_AL.setCarbon_Plus4_A(bean_header.getCarbon_Plus4_A());
                       Mem_AL.setCarbon_4_8_A(bean_header.getCarbon_4_8_A());
                       Mem_AL.setCarbon_8_30_A(bean_header.getCarbon_8_30_A());
                       Mem_AL.setCarbon_negative30_A(bean_header.getCarbon_negative30_A());
                       Mem_AL.setDust_A(bean_header.getDust_A());
                       Mem_AL.setStone_A(bean_header.getStone_A());
                       Mem_AL.setLost_A(bean_header.getLost_A());
                       //-------------------------N------------------------------
                       Mem_AL.setCarbon_Plus4_N(bean_header.getCarbon_Plus4_N());
                       Mem_AL.setCarbon_4_8_N(bean_header.getCarbon_4_8_N());
                       Mem_AL.setCarbon_8_30_N(bean_header.getCarbon_8_30_N());
                       Mem_AL.setCarbon_negative30_N(bean_header.getCarbon_negative30_N());
                       Mem_AL.setDust_N(bean_header.getDust_N());
                       Mem_AL.setStone_N(bean_header.getStone_N());
                       Mem_AL.setLost_N(bean_header.getLost_N());
                       //-------------------------S------------------------------
                       Mem_AL.setCarbon_Plus4_S(bean_header.getCarbon_Plus4_S());
                       Mem_AL.setCarbon_4_8_S(bean_header.getCarbon_4_8_S());
                       Mem_AL.setCarbon_8_30_S(bean_header.getCarbon_8_30_S());
                       Mem_AL.setCarbon_negative30_S(bean_header.getCarbon_negative30_S());
                       Mem_AL.setDust_S(bean_header.getDust_S());
                       Mem_AL.setStone_S(bean_header.getStone_S());
                       Mem_AL.setLost_S(bean_header.getLost_S());
                       AL_Obj.add(Mem_AL);
                    }
                }
            }else{
                for(int i = 1 ; i<= 2;i++){
                    if(i==1){
                        AL_Obj.get(AL_Obj.size()-1).setDoc_id(bean_header.getDoc_id());
                        AL_Obj.get(AL_Obj.size()-1).setCarbon_out_A(bean_header.getCarbon_out_A());
                        AL_Obj.get(AL_Obj.size()-1).setCarbon_out_N(bean_header.getCarbon_out_N());
                        AL_Obj.get(AL_Obj.size()-1).setCarbon_out_S(bean_header.getCarbon_out_S());
                    }else{
                        DataBean_burn_out_and_split Mem_AL = new DataBean_burn_out_and_split();
                        Mem_AL.setProduction_no(bean_header.getProduction_no());
                        ///------------------------A----------------------------
                       Mem_AL.setCarbon_Plus4_A(bean_header.getCarbon_Plus4_A());
                       Mem_AL.setCarbon_4_8_A(bean_header.getCarbon_4_8_A());
                       Mem_AL.setCarbon_8_30_A(bean_header.getCarbon_8_30_A());
                       Mem_AL.setCarbon_negative30_A(bean_header.getCarbon_negative30_A());
                       Mem_AL.setDust_A(bean_header.getDust_A());
                       Mem_AL.setStone_A(bean_header.getStone_A());
                       Mem_AL.setLost_A(bean_header.getLost_A());
                       //-------------------------N------------------------------
                       Mem_AL.setCarbon_Plus4_N(bean_header.getCarbon_Plus4_N());
                       Mem_AL.setCarbon_4_8_N(bean_header.getCarbon_4_8_N());
                       Mem_AL.setCarbon_8_30_N(bean_header.getCarbon_8_30_N());
                       Mem_AL.setCarbon_negative30_N(bean_header.getCarbon_negative30_N());
                       Mem_AL.setDust_N(bean_header.getDust_N());
                       Mem_AL.setStone_N(bean_header.getStone_N());
                       Mem_AL.setLost_N(bean_header.getLost_N());
                       //-------------------------S------------------------------
                       Mem_AL.setCarbon_Plus4_S(bean_header.getCarbon_Plus4_S());
                       Mem_AL.setCarbon_4_8_S(bean_header.getCarbon_4_8_S());
                       Mem_AL.setCarbon_8_30_S(bean_header.getCarbon_8_30_S());
                       Mem_AL.setCarbon_negative30_S(bean_header.getCarbon_negative30_S());
                       Mem_AL.setDust_S(bean_header.getDust_S());
                       Mem_AL.setStone_S(bean_header.getStone_S());
                       Mem_AL.setLost_S(bean_header.getLost_S());
                       AL_Obj.add(Mem_AL);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if(rs != null){
               rs.close();
            }
        }
        return AL_Obj;
    }

    public String Format_Date_to_Doc_ID(String Date, String Shift, String Burn_no, String C_type) {
        DecimalFormat df = new DecimalFormat("000");
        C_type = C_type.length() != 2 ? C_type+"-":C_type;
        return Date + Shift + df.format(Integer.parseInt(Burn_no)) + C_type ;
    }
}
