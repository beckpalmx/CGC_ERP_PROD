package com.cgc.Util;

import java.sql.Connection;
import java.sql.ResultSet;

import com.cgc.DB.DBConnect;
import com.cgc.bean.DataBean_Screen_Process;
import java.sql.SQLException;

public class HeaderScreen_Process {

    public DataBean_Screen_Process selectheaderscreen_process(DataBean_Screen_Process databean, String Screen_name) throws Exception {
        String SQL = "Select * from vscreen_process where screen_id = '" + Screen_name + "' and delete_flag <> 'Y'";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                databean.setIso_no(rs.getString("iso_no"));
                databean.setEffective_date(rs.getString("effective_date"));
                databean.setWarehouse_begin_id(rs.getString("warehouse_begin_id"));
                databean.setWarehouse_begin_name(rs.getString("warehouse_begin_name"));
                databean.setWarehouse_end_id(rs.getString("warehouse_end_id"));
                databean.setWarehouse_end_name(rs.getString("warehouse_end_name"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return databean;
    }
}
