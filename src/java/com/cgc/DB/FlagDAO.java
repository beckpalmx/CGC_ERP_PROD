package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FlagDAO {
    public void  updateDel(String table,String statement) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE  "+table+" set complete_flag = 'Y' "+statement;
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
}
