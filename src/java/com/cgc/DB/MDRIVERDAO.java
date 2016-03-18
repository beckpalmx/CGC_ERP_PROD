package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.bean.DataBeanMDRIVER;

public class MDRIVERDAO {
	
	public int insert(DataBeanMDRIVER dataBean) throws Exception
	{
		DBConnect objcon = new DBConnect();
		Connection con = objcon.openNewConnection();
		String sql = "insert into  mdriver (driver_id,name_t,remark,create_date) values(?,?,?,?)";
		PreparedStatement p = null;
		try
		{
			p = con.prepareStatement(sql);
			p.setString(1,dataBean.getDriver_id());
    		p.setString(2,dataBean.getName_t());
    		p.setString(3,dataBean.getRemark());
    		p.setTimestamp(4,dataBean.getDate());
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
	public int update(DataBeanMDRIVER dataBean) throws Exception
	{
		DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = 
    		"update  mdriver set  name_t=?,remark=?,update_date=? where driver_id=?";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1,dataBean.getName_t());
    		p.setString(2,dataBean.getRemark());
    		p.setTimestamp(3,dataBean.getDate());
    		p.setString(4,dataBean.getDriver_id());
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
	public int UpDel(DataBeanMDRIVER dataBean) throws Exception
    {
    	DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = "update  mdriver set delete_flag = ?,delete_date=? where driver_id=? ";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1, "Y");
    		p.setTimestamp(2, dataBean.getDate());
    		p.setString(3, dataBean.getDriver_id());
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
