package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cgc.bean.DataBeanMPROCESS_GRP;

public class MPROCESS_GRPDAO {

	public int insert(DataBeanMPROCESS_GRP dataBean) throws Exception
	{
		DBConnect objcon = new DBConnect();
		Connection con = objcon.openNewConnection();
		String sql = "insert into mprocess_group (procgrp_id,remark,name_t,create_date) values(?,?,?,?)";
		PreparedStatement p = null;
		try
		{
			p = con.prepareStatement(sql);
    		p.setString(1,dataBean.getProcgrp_id());
    		p.setString(2,dataBean.getRemark());
    		p.setString(3, dataBean.getName_t());
    		p.setTimestamp(4, dataBean.getDate());
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
	public int update(DataBeanMPROCESS_GRP dataBean) throws Exception
	{
		DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = 
    		"update mprocess_group set remark=?,name_t=?,update_date=? where procgrp_id=?";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		
    		p.setString(1,dataBean.getRemark());
    		p.setString(2, dataBean.getName_t());
    		p.setTimestamp(3, dataBean.getDate());
    		p.setString(4,dataBean.getProcgrp_id());

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
	public int UpDel(DataBeanMPROCESS_GRP dataBean) throws Exception
    {
    	DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = "update mprocess_group set delete_flag = ? , delete_date = ? where procgrp_id=? ";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1, "Y");
    		p.setTimestamp(2, dataBean.getDate());
    		p.setString(3, dataBean.getProcgrp_id());
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
