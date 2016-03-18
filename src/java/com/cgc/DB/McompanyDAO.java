/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;  //ใช้ DB ทุกตัวใน Folder เดียวกัน

import com.cgc.bean.DataBean_Mcompany;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class McompanyDAO {

    public DataBean_Mcompany selectData_chk(DataBean_Mcompany data) throws Exception {
        DataBean_Mcompany DataBean_Mcompany = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mcompany where delete_flag = 'N'";
        System.out.println(sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();
            while (rs.next()) {
                DataBean_Mcompany = new DataBean_Mcompany();
                DataBean_Mcompany.setRunno(rs.getInt("runno"));
                DataBean_Mcompany.setCompany_id(rs.getString("company_id"));
                DataBean_Mcompany.setName_t(rs.getString("name_t"));
                System.out.println(rs.getString("name_t"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return DataBean_Mcompany;
        }
    }
}
