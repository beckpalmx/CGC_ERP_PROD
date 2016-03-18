<%@page import="com.cgc.DB.Mcarbon_sizeDAO"%>
<%@page import="com.cgc.bean.DataBeanMcarbon_size"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanMcarbon_size objdb = new DataBeanMcarbon_size();
    Mcarbon_sizeDAO objex = new Mcarbon_sizeDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    int last_id = 0;
    int statusdel = 0;
    int statusnumdel1, statusnumdel2 = 0;

    String name_t = "";
    System.out.println("before name_t = " + request.getParameter("name_t"));
    name_t = request.getParameter("name_t").replace("X", "x");
    System.out.println("NameT " + name_t);

    int size_order = 9;

    /*    Old Compare
     if (!name_t.substring(1, 1).equals("+") && !name_t.substring(1, 1).equals("-")
     && !name_t.substring(1, 1).equals("B") && !name_t.substring(1, 1).equals("ถ")
     && !name_t.substring(1, 1).equals("ค") && !name_t.substring(1, 1).equals("ฝ")
     && !name_t.substring(1, 1).equals("ใ")) {
     */
    
    // ใส่ size_order เพื่อเรียงลำดับในรายงาน Check ตามขนาดของถ่าน 
    
    if (name_t.substring(1, 1).equals("1") && name_t.substring(1, 1).equals("2")
            && name_t.substring(1, 1).equals("3") && name_t.substring(1, 1).equals("4")
            && name_t.substring(1, 1).equals("5") && name_t.substring(1, 1).equals("6")
            && name_t.substring(1, 1).equals("7") && name_t.substring(1, 1).equals("8")
            && name_t.substring(1, 1).equals("9") && name_t.substring(1, 1).equals("0")) 
    {
        size_order = 1;
    } else if (name_t.substring(1, 1).equals("+")) {
        size_order = 2;
    } else if (name_t.substring(1, 1).equals("-")) {
        size_order = 3;    
    } else if (name_t.substring(1, 1).equals("ค")) {
        size_order = 4;
    }    

    System.out.println("Size Order = " + size_order);

    if (request.getParameter("status_d") == null) {
        //statusnum = uti.numRowdatabase("Select Count(size_id) As num from  m_carbon_size where name_t = '" + en.EncodeTexttoTIS(request.getParameter("name_t").trim()) + "' and delete_flag <> 'Y'");
        statusnum = uti.numRowdatabase("Select Count(size_id) As num from  m_carbon_size where name_t = '" + en.EncodeTexttoTIS((name_t).trim()) + "' and delete_flag <> 'Y'");
        if (statusnum == 0) {
            statusck = 1;
            System.out.println("1");
        } else if (statusnum == 1) {
            statusck = 2;
            System.out.println("2");
        } else {
            statusck = -1;
            System.out.println("1");
        }
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
        System.out.println("size id = " + request.getParameter("size_id"));
        if (request.getParameter("size_id").equalsIgnoreCase("")) {
            statusdel = 3;
        } else {

            System.out.println("Condition 3 STATUS D = " + request.getParameter("status_d"));
            System.out.println("statusck = " + statusck);
            statusnumdel1 = uti.numRowdatabase("Select Count(size) As num from  d_packing_product_detail where size = '" + en.EncodeTexttoTIS(request.getParameter("size_id").trim()) + "'");
            statusnumdel2 = uti.numRowdatabase("Select Count(size) As num from  d_product_receive_detail where size = '" + en.EncodeTexttoTIS(request.getParameter("name_t").trim()) + "'");

            System.out.println("statusnumdel1 = " + statusnumdel1);
            System.out.println("statusnumdel2 = " + statusnumdel2);

            if (statusnumdel1 == 0 && statusnumdel2 == 0) {
                statusdel = 1; //ลบได้
            } else {
                statusdel = 2; //ลบไม่ได้
            }
            System.out.println("statusdel final = " + statusdel);
        }

    }

    if (statusck == 1) {
        last_id = uti.numRowdatabase("Select max(size_id) As num from  m_carbon_size where delete_flag <> 'Y'");
        last_id = last_id + 1;
        System.out.println("last_id = " + last_id);
        objdb.setSize_id(last_id);
    } else {
        objdb.setSize_id(Integer.parseInt(en.EncodeTexttoTIS(request.getParameter("size_id"))));
        System.out.println("size_id = " + request.getParameter("size_id"));
    }

    //objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
    objdb.setSize_order(size_order);
    objdb.setName_t(en.EncodeTexttoTIS(name_t));
    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);
    objdb.setBy(request.getParameter("username"));

    switch (statusck) {
        case 1:
            if (objex.insert(objdb) != -1) {
                out.print("บันทึกสำเร็จ");
            }
            break;
        case 2:
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                objex.update(objdb);
                out.print("แก้ไขสำเร็จ");
            } else {
                out.print("edit");
            }
            break;
        case 3:
            if (statusdel == 1) {
                if (objex.updateDel(objdb) != -1) {
                    out.print("ลบข้อมูลสำเร็จ");
                }
            } else if (statusdel == 2) {
                out.print("ไม่สามารถลบข้อมูลได้ เพราะมีการใช้ข้อมูลนี้อยู่ !!!");
            } else if (statusdel == 3) {
                out.print("กรุณาป้อนรหัสที่ต้องการลบ !!!");
            }

            /*
             if (objex.updateDel(objdb) != -1) {
             out.print("ลบข้อมูลสำเร็จ");
             }*/
            break;
        default:
            out.print("No Statment");
    }
%>