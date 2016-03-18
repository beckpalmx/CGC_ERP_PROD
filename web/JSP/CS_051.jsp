<%@page import="com.cgc.Calculator.CostCal"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.FlagDAO"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.DB.T_WareHouseDAO"%>
<%@page import="com.cgc.bean.T_WareHouseBean"%>
<%@page import="com.cgc.DB.T_StrockDAO"%>
<%@page import="com.cgc.bean.T_StockBean"%>
<%@page import="com.cgc.DB.AddCostDAO"%>
<%@page import="com.cgc.bean.CostProductBean"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    DBConnect dbConnect = new DBConnect();
    Connection con;
    String sql_main, sql_sub;
    PreparedStatement p = null;
    ResultSet rs;
    double cost = 0;
    String id = "";
    String[] idList;
    int cnt = 0;
    DecimalFormat df = new DecimalFormat("#,###.00");
    UserBean userbean;
%>
<%
            sql_main = "select * from mstd_cost_main where process_id = 'PR_029' and delete_flag <> 'Y'  order by runno";
            try {
                con = dbConnect.openNewConnection();
                p = con.prepareStatement(sql_main);
                rs = p.executeQuery();
                while (rs.next()) {
                    id += rs.getString("std_id") + ",";
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            } finally {
                try {
                    p.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }
            }
            idList = id.split(",");
            sql_sub = "select * from vmstd_cost_sub where std_id = ? and delete_flag <> 'Y'  order by runno";
            CostProductBean costBean;
            String datacnt = (String) request.getParameter("cntData");
            cnt = Integer.parseInt(datacnt);

            String[] list;
            String data;
            AddCostDAO costDAO = new AddCostDAO();


            //********************************************
            userbean = (UserBean) session.getAttribute("user");
            T_StockBean tStockBean = new T_StockBean();
            T_StrockDAO tStockDAO = new T_StrockDAO();
            T_WareHouseBean whBean = new T_WareHouseBean();
            T_WareHouseDAO whDAO = new T_WareHouseDAO();
            T_WareHouseBean whBeanTotal = new T_WareHouseBean();
            T_WareHouseDAO whTotakDAO = new T_WareHouseDAO();
            //*********************************************
            //******** set Transection Stock
            for (int i = 0; i < cnt; i++) {
                String name_ = "param" + (i + 1);
                data = (String) request.getParameter(name_);
                list = data.split(":");

                DataBeanMPROCESS mProcess = new DataBeanMPROCESS();
                MPROCESSDAO proDAO = new MPROCESSDAO();
                FlagDAO flagDAO = new FlagDAO();
                mProcess = proDAO.selectData("PR_034");

                //******************* transtock - *****************

                tStockBean.setDoc_no(list[0]);
                tStockBean.setProcess_id("PR_034");
                tStockBean.setLocation_id(list[5]); //*** get Location_out form CS_051
                tStockBean.setProduct_id(list[1]);
                tStockBean.setWeight(list[4]);
                tStockBean.setWh_in(mProcess.getWh_bg());
                tStockBean.setDoc_type("-");
                tStockBean.setCreate_date(new Timestamp(new java.util.Date().getTime()));
                tStockBean.setCreate_by(userbean.getUsername());
                whBean = whDAO.selectData(tStockBean);
                whBeanTotal = whTotakDAO.selectData_Total(tStockBean);
                String price_t = "";
                String price_total = "";
                if (whBean != null) {
                    T_WareHouseBean whData = new T_WareHouseBean();
                    T_WareHouseBean whDataTotal = new T_WareHouseBean();
                    whData.setWarehouse_id(mProcess.getWh_bg());
                    whData.setLocation_id(list[5]); //*** get Location_out form CS_051
                    whData.setProduct_id(list[1]);
                    double quant = Double.parseDouble(whBean.getWeight()) - Double.parseDouble(list[4]);
                    whData.setWeight(quant + "");
                    double price_ = Double.parseDouble(whBean.getPrice());
                    whData.setWh_value(new CostCal().calCost(price_, quant) + "");
                    double total = new CostCal().calCostWh_Price(Double.parseDouble(whData.getWh_value()), quant);
                    whData.setPrice(df.format(total) + "");
                    whData.setUpdate_date(new Timestamp(new java.util.Date().getTime()));
                    whData.setUpdate_by(userbean.getUsername());
                    whDAO.update(whData);

                    whDataTotal = whData;
                    double price_T = Double.parseDouble(whBeanTotal.getPrice());
                    whDataTotal.setWh_value(price_T+"");
                    double quant_T = Double.parseDouble(whBeanTotal.getWeight()) - Double.parseDouble(list[4]);
                    whDataTotal.setWeight(quant_T + "");
                    double total_T = new CostCal().calCostWh_Price(Double.parseDouble(whDataTotal.getWh_value()), quant_T);
                    whDataTotal.setPrice(df.format(total_T) + "");
                    whTotakDAO.updateTotal(whDataTotal);

                    price_t = whBean.getPrice();
                    price_total = whBeanTotal.getPrice();
                    tStockDAO.insertDetail(tStockBean, "wh_out");
                }
                //******************* transtock + *****************
                tStockBean.setWh_in(mProcess.getWh_en());
                tStockBean.setLocation_id(list[3]); //*** get Location_in form CS_051
                tStockBean.setDoc_type("+");
                whBean = new T_WareHouseBean();
                whBean = whDAO.selectData(tStockBean);
                whBeanTotal = whTotakDAO.selectData_Total(tStockBean);

                if (whBean != null) {
                    T_WareHouseBean whData = new T_WareHouseBean();
                    T_WareHouseBean whDataTotal = new T_WareHouseBean();
                    whData.setWarehouse_id(mProcess.getWh_en());
                    whData.setLocation_id(list[3]); //*** get Location_in form CS_051
                    whData.setProduct_id(list[1]);
                    double quant = Double.parseDouble(whBean.getWeight()) + Double.parseDouble(list[4]);
                    whData.setWeight(quant + "");
                    double price_ = Double.parseDouble(price_t) * quant;
                    double total = new CostCal().calCostWh_Price(price_, quant);
                    whData.setWh_value(price_ + "");
                    whData.setPrice(df.format(total) + "");
                    whData.setUpdate_date(new Timestamp(new java.util.Date().getTime()));
                    whData.setUpdate_by(userbean.getUsername());
                    whDAO.update(whData);

                    whDataTotal = whData;
                    double quant_T = Double.parseDouble(whBeanTotal.getWeight()) + Double.parseDouble(list[4]);
                    whDataTotal.setWeight(quant_T + "");
                    double price_T = Double.parseDouble(price_total) * quant_T;
                    whDataTotal.setWh_value(price_T+"");
                    double total_T = new CostCal().calCostWh_Price(price_T, quant_T);
                    whDataTotal.setPrice(df.format(total_T) + "");
                    whTotakDAO.updateTotal(whDataTotal);

                    tStockDAO.insertDetail(tStockBean, "wh_out");
                } else {
                    T_WareHouseBean whData = new T_WareHouseBean();
                    T_WareHouseBean whDataTotal = new T_WareHouseBean();
                    whData.setWarehouse_id(list[2]);
                    whData.setLocation_id(list[3]); //*** get Location_in form CS_051
                    whData.setProduct_id(list[1]);
                    double quant = Double.parseDouble(list[4]);
                    whData.setWeight(quant + "");
                    double price_ = Double.parseDouble(price_t) * quant;
                    double total = new CostCal().calCostWh_Price(price_, quant);
                    whData.setPrice(df.format(total) + "");
                    whData.setWh_value(price_ + "");
                    whData.setCreate_date(new Timestamp(new java.util.Date().getTime()));
                    whData.setCreate_by(userbean.getUsername());
                    whDAO.insertDetail(whData);

                    if(whBeanTotal != null){
                        whDataTotal = whData;
                        double quant_T = Double.parseDouble(whBeanTotal.getWeight()) + Double.parseDouble(list[4]);
                        whDataTotal.setWeight(quant_T + "");
                        double price_T = Double.parseDouble(price_total) * quant_T;
                        whDataTotal.setWh_value(price_T+"");
                        double total_T = new CostCal().calCostWh_Price(price_T, quant_T);
                        whDataTotal.setPrice(df.format(total_T) + "");
                        whTotakDAO.updateTotal(whDataTotal);
                    }else{
                        whTotakDAO.insertDetail_Total(whData);
                    }

                    tStockDAO.insertDetail(tStockBean, "wh_out");
                }
                //***** set compeat flag ******
                flagDAO.updateDel(mProcess.getSub_table1(), "where doc_id = '" + list[0] + "'");
            }

            for (String stdId : idList) {
                try {

                    //*******************************************
                    con = dbConnect.openNewConnection();
                    p = con.prepareStatement(sql_sub);
                    p.setString(1, stdId);
                    rs = p.executeQuery();
                    while (rs.next()) {
                        for (int i = 0; i < cnt; i++) {
                            String name = "param" + (i + 1);
                            data = (String) request.getParameter(name);
                            list = data.split(":");
                            costBean = new CostProductBean();
                            costBean.setDoc_id(list[0]);
                            costBean.setJob_id("");
                            costBean.setOh_id(rs.getString("oh_id"));
                            costBean.setCreate_date(new Timestamp(new java.util.Date().getTime()));
                            costBean.setStd_id(rs.getString("std_id"));
                            costBean.setStd_sub_id(rs.getString("std_sub_id"));
                            costBean.setDriver_id(rs.getString("driver_id"));
                            String type = rs.getString("doc_type");
                            String w = list[5];
                            if (type.equals("N")) {
                                double costvalue = Double.parseDouble(rs.getString("cost_value"));
                                double weigth = Double.parseDouble(w);
                                cost = new CostCal().calCost(costvalue, weigth);
                                costBean.setCost_value(cost + "");
                            } else {
                                String total_price = whBean.getPrice();
                                double price = Double.parseDouble(total_price) * Double.parseDouble(list[4]);
                                cost = price;
                                costBean.setCost_value(cost + "");
                            }
                            costBean.setCreate_by(userbean.getUsername());
                            costDAO.insertDetail(costBean);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                } finally {
                    try {
                        p.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace(System.out);
                    }
                }

            }

%>