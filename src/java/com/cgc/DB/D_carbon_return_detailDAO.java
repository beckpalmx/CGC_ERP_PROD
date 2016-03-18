/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_return_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_return_detailDAO {

    private int Returnvalue;

    public int insert(DataBeanD_carbon_return_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_return_detail (doc_id,line_no,prd_no,size,c_type,iod,comp_palate,late_no,machine,size_cont,bag,s_weight,weight,reason_ret,remark,create_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getPrd_no());
            p.setString(4, dataBean.getSize());
            p.setString(5, dataBean.getC_type());
            p.setString(6, dataBean.getIod());
            p.setString(7, dataBean.getComp_palate());
            p.setString(8, dataBean.getLate_no());
            p.setString(9, dataBean.getMachine());
            p.setString(10, dataBean.getSize_cont());
            p.setString(11, dataBean.getBag());
            p.setString(12, dataBean.getS_weight());
            p.setString(13, dataBean.getWeight());
            p.setString(14, dataBean.getReason_ret());
            p.setString(15, dataBean.getRemark());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            Returnvalue = p.executeUpdate();
        } finally {

            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_return_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_return_detail set  prd_no=?,size=?,c_type=?,iod=?,comp_palate=?,late_no=?,machine=?,size_cont=?,bag=?,s_weight=?,weight=?,reason_ret=?,remark=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getPrd_no());
            p.setString(2, dataBean.getSize());
            p.setString(3, dataBean.getC_type());
            p.setString(4, dataBean.getIod());
            p.setString(5, dataBean.getComp_palate());
            p.setString(6, dataBean.getLate_no());
            p.setString(7, dataBean.getMachine());
            p.setString(8, dataBean.getSize_cont());
            p.setString(9, dataBean.getBag());
            p.setString(10, dataBean.getS_weight());
            p.setString(11, dataBean.getWeight());
            p.setString(12, dataBean.getReason_ret());
            p.setString(13, dataBean.getRemark());
            p.setTimestamp(14, dataBean.getDate());
            p.setString(15, dataBean.getBy());
            p.setString(16, dataBean.getDoc_id());
            p.setString(17, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public DataBeanD_carbon_return_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_return_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,line_no,prd_no,size,c_type,iod,comp_palate,late_no,machine,size_cont,bag,s_weight,weight,reason_ret,remark,"
                + "(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = d_carbon_return_detail.prd_no) as prd_name,"
                + "(select mproduct_cat.name_t from mproduct_cat where mproduct_cat.pcat_id = d_carbon_return_detail.c_type) as c_type_name "
                + " from d_carbon_return_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and complete_flag ='N' and delete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setPrd_no(rs.getString("prd_no"));
                bean.setSize(rs.getString("size"));
                bean.setC_type(rs.getString("c_type"));
                bean.setIod(rs.getString("iod"));
                bean.setComp_palate(rs.getString("comp_palate"));
                bean.setLate_no(rs.getString("late_no"));
                bean.setMachine(rs.getString("machine"));
                bean.setSize_cont(rs.getString("size_cont"));
                bean.setBag(rs.getString("bag"));
                bean.setS_weight(rs.getString("s_weight"));
                bean.setWeight(rs.getString("weight"));
                bean.setReason_ret(rs.getString("reason_ret"));
                bean.setRemark(rs.getString("remark"));
                bean.setPrd_no_desc(rs.getString("prd_name"));
                bean.setC_type_desc(rs.getString("c_type_name"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_return_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        boolean pclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_carbon_return_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                pclose = true;
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_return_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_carbon_return_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_return_detail set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }

                        ckclose = true;
                    }
                }
            }

        } finally {
            try {
                if (ckclose) {
                    rs.close();
                }
                if (pclose) {
                    p.close();
                }
                con.close();

            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);

    }

    public int Delete_line_no_All(DataBeanD_carbon_return_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        int total = 0;
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_return_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return total;

    }

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "Select doc_id,line_no,prd_no,size,c_type,iod,comp_palate,late_no,machine,size_cont,bag,s_weight,weight,reason_ret,remark from vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_108.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("prd_no") + "</a></td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("size") + "</td>";
            strOutput += "<td class='forborder' width='11%'>" + rs.getString("c_type") + "</td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("iod") + "</td>";
            strOutput += "<td class='forborder' width='13%'>" + rs.getString("comp_palate") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("late_no") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("machine") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("size_cont") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("bag") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("s_weight") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("weight") + "</td>";
            strOutput += "<td class='forborder' width='11%'>" + rs.getString("reason_ret") + "</td>";
            strOutput += "<td class='forborder' width='8%'>" + rs.getString("remark") + "</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
    /*public ArrayList<DataBeanD_carbon_return_detail> selectDataSearch(String id) throws Exception {
        DataBeanD_carbon_return_detail dataBean = null;
        ArrayList<DataBeanD_carbon_return_detail> list = new ArrayList<DataBeanD_carbon_return_detail>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vd_carbon_return_detail where delete_flag <> 'Y' and complete_flag = 'N' and doc_id=? order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                dataBean = new DataBeanD_carbon_return_detail();
                dataBean.setDoc_id(rs.getString("doc_id"));
                dataBean.setProduct_id(rs.getString("product_id"));
                dataBean.setSize(rs.getString("s_weight_ret"));
                dataBean.setBag_ret(rs.getString("bag_ret"));
                dataBean.setWeight(rs.getString("weight_ret"));
                dataBean.setLocation_id(rs.getString("location_id"));
                dataBean.setWh_id(rs.getString("wh_id"));
                dataBean.setConfirm(rs.getString("confirm"));

                list.add(dataBean);
            }
        }catch (Exception e){
            e.printStackTrace(System.out);
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }*/
    public String showDetailView(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "Select doc_id,line_no,prd_no,size,c_type,iod,comp_palate,late_no,machine,size_cont,bag,s_weight,weight,reason_ret,remark from vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("prd_no") + "</a></td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("size") + "</td>";
            strOutput += "<td class='forborder' width='11%'>" + rs.getString("c_type") + "</td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("iod") + "</td>";
            strOutput += "<td class='forborder' width='13%'>" + rs.getString("comp_palate") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("late_no") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("machine") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("size_cont") + "</td>";
            strOutput += "<td class='forborder' width='5%'>" + rs.getString("bag") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("s_weight") + "</td>";
            strOutput += "<td class='forborder' width='6%'>" + rs.getString("weight") + "</td>";
            strOutput += "<td class='forborder' width='11%'>" + rs.getString("reason_ret") + "</td>";
            strOutput += "<td class='forborder' width='8%'>" + rs.getString("remark") + "</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
    public String ShowDetailApprove(String Doc_id)throws Exception{
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(Doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        strOutput += "<table width='200' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n";
        SQL = "Select * from vd_carbon_return_detail where doc_id ='" + objth.EncodeTexttoTIS(Doc_id) + "'and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>\n";
            strOutput += "<td class='forborder' width='3%'><input type='checkbox' id='ckbox_"+rs.getString("line_no")+"' name='ckbox' value = '"+rs.getString("line_no")+"' onclick=\"cancle_chkboxAll('chk_all',this.checked);getId('show_comfirm_"+rs.getString("line_no")+"').innerHTML = this.checked?'ยืนยัน':'รอการยืนยัน';\"></td>\n";
            strOutput += "<td class='forborder' width='3%'><a href='javascript:;' onclick='viewDetail()'>" + rs.getString("line_no") + "</a></td>\n";
            strOutput += "<td class='forborder' width='26%'><input type = 'text' id = 'product_id_"+rs.getString("line_no")+"' name = 'product_id' value = '"+ rs.getString("c_type") +"' size = 20><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_"+rs.getString("line_no")+"', 31, 'Search_Detail.jsp')\"></a></td>\n";
            strOutput += "<td class='forborder' width='9%'>" + rs.getString("bag") + "</td>\n";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("s_weight") + "</td>\n";
            strOutput += "<td class='forborder' width='10%'><input type = 'text' id = 'weight_"+rs.getString("line_no")+"' name = 'weight' value = '" + rs.getString("weight") + "' size = 9><input type = 'hidden' id = 'weight_doc_id_"+rs.getString("line_no")+"' name = 'weight_doc_id' value = '"+rs.getString("weight")+"'></td>\n";
            strOutput += "<td class='forborder' width='15%'><input type = 'text' id = 'warehouse_id_"+rs.getString("line_no")+"' name = 'warehouse_id' value = '" + objuti.NotNull(rs.getString("wh_id")) + "' size = 12><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_"+rs.getString("line_no")+"', 48, 'Search_Detail.jsp')\"></a></td>\n";
            strOutput += "<td class='forborder' width='12%'><input type = 'text' id = 'location_id_"+rs.getString("line_no")+"' name = 'location_id' value ='' size = 10><input type = 'hidden' id='job_id_" + rs.getString("line_no") + "' name = 'job_id' value = '" + rs.getString("prd_no") + "'></td>\n";
            strOutput += "<td class='forborder' width='12%'><div id = 'show_comfirm_"+rs.getString("line_no")+"'>รอการยืนยัน</div></td>\n";
            strOutput += "</tr>\n";
        }
        if(rs != null){
            rs.close();
        }if(con != null){
            con.close();
        }
        
        strOutput += "</table>\n";
        return strOutput;
    }

    
}
