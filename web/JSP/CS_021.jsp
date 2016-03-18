<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.ProductBean"%>
<%@page import="com.cgc.DB.ProductDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.bean.UserBean"%>
<%!    ProductDAO pDAO = new ProductDAO();
    ProductBean proBean, selectPgBean;
    Timestamp ts;
    String name, id_wh, rm, id, id_g, id_c, id_t, price, max, min, safety, lo_id, value,weight;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            id = (String) request.getParameter("product_id");
            name = (String) request.getParameter("name_t_product");
            id_g = (String) request.getParameter("pgroup_id");
            id_c = (String) request.getParameter("pcat_id");
            id_t = (String) request.getParameter("ptype_id");
            price = (String) request.getParameter("price");
            min = (String) request.getParameter("min");
            max = (String) request.getParameter("max");
            lo_id = (String) request.getParameter("location_id");
            value = (String) request.getParameter("value");
            safety = (String) request.getParameter("safety");
            id_wh = (String) request.getParameter("warehouse_id");
            weight = (String) request.getParameter("weight");
            rm = (String) request.getParameter("remark_product");

            pDAO = new ProductDAO();           
          
            proBean = new ProductBean();
            proBean.setName_t(tu.EncodeTexttoTIS(name));
            proBean.setProduct_id(id);
            proBean.setPgroup_id(id_g);
            proBean.setPcat_id(id_c);
            proBean.setPtype_id(id_t);
            proBean.setMin(min);
            proBean.setMax(max);
            proBean.setPrice(price);
            proBean.setLocation_id(lo_id);
            proBean.setValue(value);
            proBean.setSafety(safety);
            proBean.setQuantity("");
            proBean.setWarehouse_id(id_wh);
            proBean.setRemark(tu.EncodeTexttoTIS(rm));
            //proBean.setSize_id(tu.EncodeTexttoTIS(request.getParameter("size_id")));
            proBean.setSize_id(request.getParameter("size_id").equals("")?"0":tu.EncodeTexttoTIS(request.getParameter("size_id")));
            //proBean.setButane(tu.EncodeTexttoTIS(request.getParameter("butane")));
            //proBean.setCtc(tu.EncodeTexttoTIS(request.getParameter("ctc")));
            proBean.setButane(request.getParameter("butane")==null || request.getParameter("butane").equals("") ? "0" : tu.EncodeTexttoTIS(request.getParameter("butane")));                        
            proBean.setCtc(request.getParameter("ctc")==null || request.getParameter("ctc").equals("") ? "0" : tu.EncodeTexttoTIS(request.getParameter("ctc")));            
            proBean.setIodine(request.getParameter("iodine")==null || request.getParameter("iodine").equals("") ? "0" : tu.EncodeTexttoTIS(request.getParameter("iodine")));
            proBean.setUnit_id(tu.EncodeTexttoTIS(request.getParameter("unit_id")));
            proBean.setLot_no(tu.EncodeTexttoTIS(request.getParameter("lot_no")));
            ts = new Timestamp(new java.util.Date().getTime());
            proBean.setScreen_id(request.getParameter("screen_id"));
            System.out.println("Screen ID = " + request.getParameter("screen_id"));            
            proBean.setCreate_date(ts);
            proBean.setUpdate_date(ts);
            proBean.setCreate_by(request.getParameter("username"));            
            proBean.setUpdate_by(request.getParameter("username"));            
            proBean.setWeight(request.getParameter("weight"));
            if (request.getParameter("chkstatus") == null) {
                selectPgBean = pDAO.selectData(id);
                if (selectPgBean != null && selectPgBean.getDelete_fag().equals("N")) {
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        proBean.setUpdate_date(ts);
                        pDAO.update(proBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (pDAO.insert(proBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                pDAO.updateDel(proBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>