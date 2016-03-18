package com.cgc.DB;
import java.sql.*;

import com.cgc.bean.DataBeanMSTD_COST_MAIN;
public class MSTD_COST_MAINDAO {
	
	public int insert(DataBeanMSTD_COST_MAIN dataBean) throws Exception
	{
		DBConnect objcon = new DBConnect();
		Connection con = objcon.openNewConnection();
		String sql = "insert into mstd_cost_main (std_id,remark,name_t,process_id,create_date) values(?,?,?,?,?)";
		PreparedStatement p = null;
		try
		{
			p = con.prepareStatement(sql);
    		p.setString(1,dataBean.getStd_id());
    		p.setString(2,dataBean.getRemark());
    		p.setString(3, dataBean.getName_t());
                p.setString(4,dataBean.getProcess_id());
    		p.setTimestamp(5, dataBean.getDate());
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
	public int update(DataBeanMSTD_COST_MAIN dataBean) throws Exception
	{
		DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = 
    		"update mstd_cost_main set remark=?,name_t=?,process_id=?,update_date=? where std_id=?";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		
    		p.setString(1,dataBean.getRemark());
    		p.setString(2, dataBean.getName_t());
                p.setString(3,dataBean.getProcess_id());
    		p.setTimestamp(4, dataBean.getDate());
    		p.setString(5,dataBean.getStd_id());

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
	public int UpDel(DataBeanMSTD_COST_MAIN dataBean) throws Exception
    {
    	DBConnect dbConnect = new DBConnect();
    	Connection con = dbConnect.openNewConnection();
    	String sql = "update mstd_cost_main set delete_flag = ? , delete_date = ? where std_id=? ";
    	PreparedStatement p = null;
    	try
    	{
    		p = con.prepareStatement(sql);
    		p.setString(1, "Y");
    		p.setTimestamp(2, dataBean.getDate());
    		p.setString(3, dataBean.getStd_id());
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
