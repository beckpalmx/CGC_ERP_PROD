/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.bean.PrintReport_Rawmat_bigbag_balance;
import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;

/**
 *
 * @author Beckpalmx No7
 */
public class PrintReport_Rawmat_bigbag_balance_1 {

    public String ShowDetail(String month_id, String price_year, String location_id) throws Exception {
        PrintReport_Rawmat_bigbag_balance objbean = new PrintReport_Rawmat_bigbag_balance();
        StringBuilder Return_String = new StringBuilder();
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        UtiDatabase objuti = new UtiDatabase();
        ResultSet rs = null;
        int count_line = 1;
        double zero = 0;
        String Cond0, Cond1 = "";
        DecimalFormat df = new DecimalFormat("#,###,##0.00");

        String SQL_Del = "delete from tmp_rawmatt_summary_bigbag ; ALTER SEQUENCE seq_tmp_rawmatt_summary_bigbag RESTART WITH 1;";

        delete_rawmatt(SQL_Del, con, p);

        System.out.println("param 1 " + price_year);
        System.out.println("param 2 " + month_id);
        System.out.println("param 3 " + location_id);

        String Str = location_id;

        String[] Str_Cond = new String[2];
        int i = 0;
        for (String retval : Str.split("\\?", 2)) {
            Str_Cond[i] = retval;
            System.out.println("value = " + i + " : " + Str_Cond[i]);

            if (!(Str_Cond[0].equals("-"))) {
                Cond1 = " and location_id = '" + Str_Cond[0] + "' ";
            } else {
                Cond1 = " and location_id like '%' ";
            }

            System.out.println("loop " + i + " Cond1 = " + Cond1);

            i++;
        }

        //String condition = Cond0 + Cond1 + " and (process_id = 'PR_025' or process_id = 'PR_057') ";
        String condition = "";

        try {

            if (month_id.equals("") && price_year.equals("")) {
                Cond0 = "Where month like '%' and year like '%' ";
            } else {
                Cond0 = "Where (month = '" + month_id + "') and year = '" + price_year + "' ";

            }

            String prev_month = "";

            if (Integer.parseInt(month_id) > 1) {
                prev_month = String.format("%02d", Integer.parseInt(month_id) - 1);
            } else {
                prev_month = month_id;
            }

            //System.out.println("prev_month = " + String.format("%02d", month_id));
            System.out.println("prev_month = " + prev_month);

            for (int x = 1; x <= 3; x = x + 1) {

                if (x == 1) {
                    condition = Cond0 + Cond1 + " and (process_id = 'PR_025') and pcat_id <> 'RAW' ";
                } else if (x == 2) {
                    condition = Cond0 + Cond1 + " and (process_id = 'PR_057') and pcat_id <> 'RAW' ";
                } else if (x == 3) {
                    Cond0 = "Where (month BETWEEN '01' and '" + prev_month + "') and year = '" + price_year + "' ";
                    condition = Cond0 + Cond1 + " and (process_id = 'PR_025' or process_id = 'PR_057') and pcat_id <> 'RAW' ";
                }

                //String SQL = "Select product_id,wh_id,location_id,sum(weight_total) as weight_total From vt_transaction_stock_process_report " + condition + "and delete_flag = 'N' "
                //+ " Group By product_id,wh_id,location_id ";
                String SQL = "Select product_id,location_id,sum(weight_total) as weight_total From vt_transaction_stock_process_report " + condition + "and delete_flag = 'N' "
                        + " Group By product_id,location_id ";

                if (x == 3) {
                    SQL = SQL + " Having sum(weight_total) > 0 ";
                }

                //SQL = SQL + " Order By product_id,wh_id,location_id ";
                SQL = SQL + " Order By product_id,location_id ";

                System.out.println("SQL = " + SQL);
                String sql1
                        = sql1 = "Select COUNT(doc_id) as num From vt_transaction_stock_process_report "
                        + condition
                        + "and delete_flag = 'N' ";
                if (objuti.numRowdatabase(sql1) >= 1) {

                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {

                        String SQL_Check_data = "SELECT count(*) as num FROM tmp_rawmatt_summary_bigbag "
                                + " WHERE product_id = '" + rs.getString("product_id") + "'"
                                //+ " AND wh_id = '" + rs.getString("wh_id") + "'"
                                + " AND location_id = '" + rs.getString("location_id") + "'";

                        objbean.setProduct_id(rs.getString("product_id"));
                        //objbean.setWh_id(rs.getString("wh_id"));
                        objbean.setLocation_id(rs.getString("location_id"));

                        if (x == 1) {
                            objbean.setRawmatt_receive(rs.getDouble("weight_total"));
                            objbean.setRawmatt_withdraw(zero);
                            objbean.setRawmatt_balance(zero);
                            objbean.setRawmatt_transfer(zero);
                        } else if (x == 2) {
                            objbean.setRawmatt_withdraw(rs.getDouble("weight_total"));
                            objbean.setRawmatt_receive(zero);
                            objbean.setRawmatt_balance(zero);
                            objbean.setRawmatt_transfer(zero);
                        } else if (x == 3) {
                            objbean.setRawmatt_transfer(rs.getDouble("weight_total"));
                            objbean.setRawmatt_receive(zero);
                            objbean.setRawmatt_balance(zero);
                            objbean.setRawmatt_withdraw(zero);
                        }
                        objbean.setMonth(month_id);
                        objbean.setYear(price_year);
                        objbean.setBy("System");
                        objbean.setDate(new Timestamp(new java.util.Date().getTime()));

                        //objbean.setRawmatt_transfer(rs.getDouble("weight_total"));
                        if (objuti.numRowdatabase(SQL_Check_data) == 0) {
                            insert_rawmatt(objbean, x);
                        } else {
                            update_rawmatt(objbean, x);
                        }

                        //   Return_String.append("</table>");
                    }
                } else {
                    System.out.println("No DATA .. ");
                }

            }

            //To Display DATA            
            String SQL = " Select * from vtmp_rawmatt_summary_bigbag Order By product_id,wh_id,location_id ";

            System.out.println("SQL = " + SQL);
            String sql1 = "Select COUNT(*) as num From vtmp_rawmatt_summary_bigbag ";

            if (objuti.numRowdatabase(sql1) >= 1) {

                Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                Return_String.append(("<td class=\"headergrid\" width=\"100%\">เดือน " + month_id + " ปี " + price_year + "</td>\n"));
                Return_String.append("</table>");

                Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");

                Return_String.append("<tr>\n");
                Return_String.append(("<td class=\"row5\" width=\"5%\">ลำดับ</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"7%\">ประเภทวัตถุดิบ</td>\n"));
                //Return_String.append(("<td class=\"row5\" width=\"7%\">คลังวัตถุดิบ</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">กองที่</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">ยอดยกมา</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">รับเข้าจากการสี</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">เบิกถุงใหญ่</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">คงเหลือ</td>\n"));

                //System.out.println(Return_String);                
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {

                    //System.out.println("D weight_total = " + rs.getDouble("weight_total"));
                    //if (rs.getDouble("weight_total") > 0) {
                    Return_String.append("<tr>\n");
                    Return_String.append(("<td class=\"forborder\" width=\"3%\">" + count_line + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"5%\">" + rs.getString("product_id") + "</td>\n"));
                    //Return_String.append(("<td class=\"forborder\" width=\"7%\">" + rs.getString("wh_id") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("location_id") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\"><p align = \"right\">" + df.format(rs.getDouble("rawmatt_transfer")) + "</p></td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\"><p align = \"right\">" + df.format(rs.getDouble("rawmatt_receive")) + "</p></td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\"><p align = \"right\">" + df.format(rs.getDouble("rawmatt_withdraw")) + "</p></td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\"><p align = \"right\">" + df.format(rs.getDouble("balance")) + "</p></td>\n"));
                    Return_String.append("</tr>\n");
                    count_line += 1;
                    //}
                }

                Return_String.append("</table>");
            } else {
                Return_String.append("<br>");
                Return_String.append("<b>ไม่พบข้อมูล</b>");
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
        }
        return Return_String.toString();

    }

    public void insert_rawmatt(PrintReport_Rawmat_bigbag_balance DataBean, int x) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            //String SQL_Insert = "INSERT INTO tmp_rawmatt_summary_bigbag(product_id, wh_id,location_id,rawmatt_transfer,rawmatt_receive,rawmatt_withdraw,rawmatt_balance,create_date,create_by,update_date) values(?,?,?,?,?,?,?,?,?,?)";
            String SQL_Insert = "INSERT INTO tmp_rawmatt_summary_bigbag(product_id, wh_id,location_id,rawmatt_transfer,rawmatt_receive,rawmatt_withdraw,rawmatt_balance,month,year) values(?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL_Insert);
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            //p.setString(i, DataBean.getWh_id());
            p.setString(i, "CF_WH");
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setDouble(i, DataBean.getRawmatt_transfer());
            i += 1;
            p.setDouble(i, DataBean.getRawmatt_receive());
            i += 1;
            p.setDouble(i, DataBean.getRawmatt_withdraw());
            i += 1;
            p.setDouble(i, DataBean.getRawmatt_balance());
            i += 1;
            p.setString(i, DataBean.getMonth());
            i += 1;
            p.setString(i, DataBean.getYear());
            i += 1;
            //p.setTimestamp(i, DataBean.getDate());
            //i += 1;
            //p.setTimestamp(i, DataBean.getDate());
            //i += 1;
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void update_rawmatt(PrintReport_Rawmat_bigbag_balance DataBean, int x) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        String sfield = "";

        if (x == 1) {
            sfield = "rawmatt_receive";
        } else if (x == 2) {
            sfield = "rawmatt_withdraw";
        } else if (x == 3) {
            sfield = "rawmatt_transfer";
        }

        try {
            //String SQL_Update = " UPDATE tmp_rawmatt_summary_bigbag SET " + sfield + "=?,update_by=?,update_date=? WHERE product_id=? and wh_id=? and location_id =? ";
            String SQL_Update = " UPDATE tmp_rawmatt_summary_bigbag SET " + sfield + "=?,update_by=?,update_date=? WHERE product_id=? and location_id =? ";
            p = con.prepareStatement(SQL_Update);

            if (x == 1) {
                p.setDouble(i, DataBean.getRawmatt_receive());
            } else if (x == 2) {
                p.setDouble(i, DataBean.getRawmatt_withdraw());
            } else if (x == 3) {
                p.setDouble(i, DataBean.getRawmatt_transfer());
            }
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            //p.setString(i, DataBean.getWh_id());
            //i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private void delete_rawmatt(String SQL_DEL, Connection con, PreparedStatement p) throws Exception {
        try {
            System.out.println("Function Delete : " + SQL_DEL);
            p = con.prepareStatement(SQL_DEL);
            p.executeUpdate();
            p.clearParameters();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

}
