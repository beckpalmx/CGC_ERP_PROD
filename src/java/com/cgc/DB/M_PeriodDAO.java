/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanM_Period;
import com.cgc.Util.StringQuery;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author B
 */
public class M_PeriodDAO {

    UtiDatabase objuti;
    StringQuery objStringQuery;
    private int Returnvalue;

    /**
     *
     * @param DataBean
     * @throws Exception
     */
    public void update(DataBeanM_Period DataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        String start_year = "", end_year = "", end_period = "";
        //UtiDatabase objuti = new UtiDatabase();
        int i = 1;
        int chk_cond = 0;
        try {
            String SQL_update = "Update mmonth set year = ? , start_date = ? , end_date = ? where runno = ? ";
            p = con.prepareStatement(SQL_update);
            p.setString(i, DataBean.getYear_period());
            i += 1;
            p.setString(i, DataBean.getStart_date());
            i += 1;
            p.setString(i, DataBean.getEnd_date());
            i += 1;
            p.setInt(i, DataBean.getRunno());
            i += 1;
            p.executeUpdate();

            String SQL_update_Mpereiod ;

            if (DataBean.getRunno() == 1) {
                start_year = DataBean.getStart_date();
                end_period = DataBean.getStart_date();
                SQL_update_Mpereiod = "Update mperiod set period_id = ? , name_t = ? , start_year = ? , start_period = ? ";
                p = con.prepareStatement(SQL_update_Mpereiod);
                p.setString(1, "P1-" + DataBean.getYear_period());
                p.setString(2, "P1-" + DataBean.getYear_period());
                p.setString(3, start_year);
                p.setString(4, start_year);
                p.executeUpdate();
            }

            if (DataBean.getRunno() == 12) {
                end_year = DataBean.getEnd_date();
                SQL_update_Mpereiod = "Update mperiod set period_id = ? , name_t = ? , end_year = ? , end_period = ? ";
                p = con.prepareStatement(SQL_update_Mpereiod);
                p.setString(1, "P1-" + DataBean.getYear_period());
                p.setString(2, "P1-" + DataBean.getYear_period());
                p.setString(3, end_year);
                p.setString(4, "31-01-" + DataBean.getYear_period() );
                p.executeUpdate();
            }

            System.out.println("Out start_year = " + start_year);
            System.out.println("Out end_year = " + end_year);

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
