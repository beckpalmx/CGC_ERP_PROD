/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.bean;

import java.sql.Timestamp;

/**
 *
 * @author com02
 */
public class TReport_LogBean {

    private int runno;
    private String log_print_id;    
    private String report_id;    
    private Timestamp create_date;
    private String create_by;
    private String start_date;    
    private String end_date; 
    private String time_usage;     
    private String company_id;    

    /**
     * @return the runno
     */
    public int getRunno() {
        return runno;
    }

    /**
     * @param runno the runno to set
     */
    public void setRunno(int runno) {
        this.runno = runno;
    }

    /**
     * @return the log_print_id
     */
    public String getLog_print_id() {
        return log_print_id;
    }

    /**
     * @param log_print_id the log_print_id to set
     */
    public void setLog_print_id(String log_print_id) {
        this.log_print_id = log_print_id;
    }

    /**
     * @return the report_id
     */
    public String getReport_id() {
        return report_id;
    }

    /**
     * @param report_id the report_id to set
     */
    public void setReport_id(String report_id) {
        this.report_id = report_id;
    }

    /**
     * @return the create_date
     */
    public Timestamp getCreate_date() {
        return create_date;
    }

    /**
     * @param create_date the create_date to set
     */
    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    /**
     * @return the create_by
     */
    public String getCreate_by() {
        return create_by;
    }

    /**
     * @param create_by the create_by to set
     */
    public void setCreate_by(String create_by) {
        this.create_by = create_by;
    }

    /**
     * @return the start_date
     */
    public String getStart_date() {
        return start_date;
    }

    /**
     * @param start_date the start_date to set
     */
    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    /**
     * @return the end_date
     */
    public String getEnd_date() {
        return end_date;
    }

    /**
     * @param end_date the end_date to set
     */
    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    /**
     * @return the time_usage
     */
    public String getTime_usage() {
        return time_usage;
    }

    /**
     * @param time_usage the time_usage to set
     */
    public void setTime_usage(String time_usage) {
        this.time_usage = time_usage;
    }

    /**
     * @return the company_id
     */
    public String getCompany_id() {
        return company_id;
    }

    /**
     * @param company_id the company_id to set
     */
    public void setCompany_id(String company_id) {
        this.company_id = company_id;
    }

}
