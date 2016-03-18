package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cgc.bean.DataBeanMoverhead;

public class MoverheadDAO {
	public int insert(DataBeanMoverhead dataBean) throws Exception
	{
		DBConnect objcon = new DBConnect();
		Connection con = objcon.openNewConnection();
		String sql = "insert into moverhead (oh_id,driver_id,name_t,account_code,remark,create_date) values(?,?,?,?,?,?)";
		PreparedStatement p = null;
		try
		{
			p = con.prepareStatement(sql);
    		p.setString(1,dataBean.getOh_id());
    		p.setString(2,dataBean.getDriver_id());
    		p.setString(3, dataBean.getName_t());
    		p.setString(4,dataBean.getAccount_code());
    		p.setString(5, dataBean.getRemark());
    		p.setTimestamp(6, dataBean.getDate());
			return p.executeUpdate();
		}
		finally
		{
			try
			{
				p.close();
				con.close();
			}
			catch (Exception e) {
				e.printStackTrace(System.out);
			}
		}
	}
	public int update(DataBeanMoverhead dataBean) throws Exception
	{
		DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = 
    		"update moverhead set driver_id=?,name_t=?,account_code=?, remark=?,update_date=? where oh_id=?";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1,dataBean.getDriver_id());
    		p.setString(2, dataBean.getName_t());
    		p.setString(3,dataBean.getAccount_code());
    		p.setString(4, dataBean.getRemark());
    		p.setTimestamp(5, dataBean.getDate());
    		p.setString(6,dataBean.getOh_id());

    		return p.executeUpdate();
    		
    	}finally{
    		try
    		{
    			p.close();
    			con.close();
    		}
    		catch(Exception e)
    		{
    			e.printStackTrace(System.out);
    		}
    	}
	}
	public int UpDel(DataBeanMoverhead dataBean) throws Exception
    {
    	DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = "update moverhead set delete_flag = ? , delete_date = ? where oh_id=? ";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1, "Y");
    		p.setTimestamp(2, dataBean.getDate());
    		p.setString(3,dataBean.getOh_id());
    		return p.executeUpdate();
    		
    	}
    	finally
    	{
    		try
    		{
    			p.close();
    			con.close();
    		}
    		catch (Exception e) {
				e.printStackTrace(System.out);
			}
    	}
    }

}
