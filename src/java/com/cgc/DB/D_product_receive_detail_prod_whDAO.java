/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_detail_prod;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class D_product_receive_detail_prod_whDAO {
    private int Returnvalue;

    public int insert(DataBeanD_product_receive_detail_prod dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_product_receive_detail_prod_wh "
                + "(doc_id,doc_date,line_no,wh_in,wh_out,machine,shift,size,weight,palate_complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,create_date,create_by,palate_chk,unit_id,job_type_id,job_type_desc) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getLine_no());
            p.setString(4, dataBean.getWh_in());
            p.setString(5, dataBean.getWh_out());
            p.setString(6, dataBean.getMachine());
            p.setString(7, dataBean.getShift());
            p.setString(8, dataBean.getSize());
            p.setString(9, dataBean.getWeight());
            p.setString(10, dataBean.getPalate_complete_code());
            p.setString(11, dataBean.getPalate_no());
            p.setString(12, dataBean.getPalate_complete());
            p.setString(13, dataBean.getCtc_i2());
            p.setString(14, dataBean.getBag());
            p.setString(15, dataBean.getEmp_id());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            p.setString(18, dataBean.getPalate_chk());
            p.setString(19,dataBean.getUnit_id());
            p.setString(20, dataBean.getJob_type_id());
            p.setString(21, dataBean.getJob_type_desc());
            Returnvalue = p.executeUpdate();
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_product_receive_detail_prod dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql = "update d_product_receive_detail_prod_wh set  "
                + "doc_date=?,wh_in=?,wh_out=?,machine=?,shift=?,size=?,weight=?,palate_complete_code=?,palate_no=?,palate_complete=?,ctc_i2=?,bag=?,emp_id=?,update_date=?,update_by=?,palate_chk=?,unit_id=?,job_type_id=?,job_type_desc=? "
                + "where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getWh_out());
            p.setString(4, dataBean.getMachine());
            p.setString(5, dataBean.getShift());
            p.setString(6, dataBean.getSize());
            p.setString(7, dataBean.getWeight());
            p.setString(8, dataBean.getPalate_complete_code());
            p.setString(9, dataBean.getPalate_no());
            p.setString(10, dataBean.getPalate_complete());
            p.setString(11, dataBean.getCtc_i2());
            p.setString(12, dataBean.getBag());
            p.setString(13, dataBean.getEmp_id());
            p.setTimestamp(14, dataBean.getDate());
            p.setString(15, dataBean.getBy());
            p.setString(16, dataBean.getPalate_chk());
            p.setString(17, dataBean.getUnit_id());
            p.setString(18, dataBean.getJob_type_id());
            p.setString(19, dataBean.getJob_type_desc());
            p.setString(20, dataBean.getDoc_id());
            p.setString(21, dataBean.getLine_no());
            //JOptionPane.showConfirmDialog(null, dataBean.getLine_no());
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

    public DataBeanD_product_receive_detail_prod ReturnEdit(String Doc_id, String Line_no, DataBeanD_product_receive_detail_prod bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,wh_in,wh_out,line_no,machine,shift,size,weight,palate_complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,"
                + "(select memployee.fname from memployee where memployee.emp_id = d_product_receive_detail_prod_wh.emp_id) as emp_name,palate_chk,unit_id,"
                + "(select munit_code.name_t from munit_code where munit_code.unit_id = d_product_receive_detail_prod_wh.unit_id) as unit_name,job_type_id,job_type_desc,size_by "
                + "from d_product_receive_detail_prod_wh where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet  rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setMachine(rs.getString("machine"));
                bean.setShift(rs.getString("shift"));
                bean.setSize(rs.getString("size"));
                bean.setWeight(rs.getString("weight"));
                bean.setPalate_complete_code(rs.getString("palate_complete_code"));
                bean.setPalate_no(rs.getString("palate_no"));
                bean.setPalate_complete(rs.getString("palate_complete"));
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setBag(rs.getString("bag"));
                bean.setEmp_id(rs.getString("emp_id"));
                bean.setEmp_name(rs.getString("emp_name"));
                bean.setPalate_chk(rs.getString("palate_chk"));
                bean.setUnit_id(rs.getString("unit_id"));
                bean.setUnit_name(rs.getString("unit_name"));
                bean.setJob_type_id(rs.getString("job_type_id"));
                bean.setJob_type_desc(rs.getString("job_type_desc"));
                bean.setSize_by(rs.getString("size_by"));
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

    public void DeleteLine_no(String inputarry, DataBeanD_product_receive_detail_prod bean) throws Exception {
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
                    sql = "update d_product_receive_detail_prod_wh set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    sql = "select count(doc_id) as num from d_product_receive_detail_prod_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    if(objuti.numRowdatabase(sql) != 0){
                    p = null;
                    sql2 = "Select line_no from  d_product_receive_detail_prod_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_product_receive_detail_prod_wh set line_no=? where doc_id=? and line_no=?";
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
                if(pclose){
                    p.close();
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);

    }

    public void Delete_line_no_All(DataBeanD_product_receive_detail_prod dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_product_receive_detail_prod_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
    }
    public String showDetail(String doc_id) throws  Exception{
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1,SQL,strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL1 = "Select Count(doc_id) As num from  d_product_receive_detail_prod_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
	SQL = "Select doc_id,line_no,size,size,weight,machine,shift,palate_complete_code,palate_no,palate_complete,ctc_i2,bag,(select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail_prod_wh.job_type_id) as job_type_name,job_type_desc,size_by from d_product_receive_detail_prod_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
	DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{
	strOutput += "<tr>";
        strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox2' name='ckbox2' onclick=\"cancle_chkboxAll('chk_all2',this.checked)\"></td>";
        strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,doc_date,username','../SCREEN/CS_045_2.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("size")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("weight")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("job_type_name")+rs.getString("job_type_desc")+"&nbsp;</td>";
	strOutput += "<td class='forborder' width='5%'>"+rs.getString("shift")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("palate_complete_code")+"&nbsp;</td>";
	strOutput += "<td class='forborder' width='10%'>"+rs.getString("palate_no")+"&nbsp;</td>";
	strOutput += "<td class='forborder' width='10%'>"+rs.getString("palate_complete")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("ctc_i2")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("bag")+"&nbsp;</td>";
	strOutput += "</tr>";
	}
	rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
    public ArrayList<DataBeanD_product_receive_detail_prod> selectDataSearch(String id) throws Exception {
        DataBeanD_product_receive_detail_prod dataBean = null;
        ArrayList<DataBeanD_product_receive_detail_prod> list = new ArrayList<DataBeanD_product_receive_detail_prod>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vd_product_receive_detail_prod where delete_flag <> 'Y' and complete_flag = 'N' and doc_id=? order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                dataBean = new DataBeanD_product_receive_detail_prod();
                dataBean.setDoc_id(rs.getString("doc_id"));
                dataBean.setProduct_id(rs.getString("product_id"));
                dataBean.setLine_no(rs.getString("line_no"));
                dataBean.setSize(rs.getString("size"));
                dataBean.setBag(rs.getString("bag"));
                dataBean.setWeight(rs.getString("weight"));
                dataBean.setCtc_i2(rs.getString("ctc_i2"));
                dataBean.setPalate_complete_code(rs.getString("palate_complete_code"));
                dataBean.setPalate_no(rs.getString("palate_no"));

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
    }
}
