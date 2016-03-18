package com.cgc.Util;



public class SelectSerchData {

    private String strTable;

    public String SelectSerchTable(String inputselect)//�觤�Ңͧ&table=?������Table�͡�
    {
        if (inputselect.equals("Driver")) {
            strTable = "mdriver";
        } else if (inputselect.equals("Overhead")) {
            strTable = "moverhead";
        } else if (inputselect.equals("CostMain")) {
            strTable = "mstd_cost_main";
        } else if (inputselect.equals("CostSub")) {
            strTable = "mstd_cost_sub";
        } else if (inputselect.equals("Vcostsub")) {
            strTable = "vmstd_cost_sub";
        } else if (inputselect.equals("Process")) {
            strTable = "mprocess";
        } else if (inputselect.equals("Department")) {
            strTable = "mdepartment";
        } else if (inputselect.equals("Vscreen")) {
            strTable = "vscreen_process";
        } else if (inputselect.equals("Mstd_cost_main")) {
            strTable = "mstd_cost_main";
        } else if (inputselect.equals("Vmoverhead")) {
            strTable = "vmoverhead";
        } else if (inputselect.equals("Vmprocess")) {
            strTable = "vmprocess";
        } else if (inputselect.equals("Process_group")) {
            strTable = "mprocess_group";
        } else if (inputselect.equals("Warehouse") || inputselect.equals("Wh_bg") || inputselect.equals("Wh_en") || inputselect.equals("Warehouse1") || inputselect.equals("Warehouse2")) {
            strTable = "mwarehouse";
        } else if (inputselect.equals("Mainmenu")) {
            strTable = "mmenu_main";
        } else if (inputselect.equals("Screen")) {
            strTable = "mscreen";
        } else if (inputselect.equals("Vmenu_sub")) {
            strTable = "vmmenu_sub";
        } else if (inputselect.equals("Vmprocess")) {
            strTable = "vmprocess";
        } else if (inputselect.equals("Vuser_account")) {
            strTable = "vmuser_account";
        } else if (inputselect.equals("Vemployee") || inputselect.equals("Vemployee1") || inputselect.equals("Vemployee2")|| inputselect.equals("Vemployee3")|| inputselect.equals("Vemployee4")|| inputselect.equals("Vemployee5")) {
            strTable = "vemployee_fullname";
        } else if (inputselect.equals("Priviledge")) {
            strTable = "mpriviledge";
        } else if (inputselect.equals("Vsupplier")) {
            strTable = "vsupplier";
        } else if (inputselect.equals("Mproduct")) {
            strTable = "mproduct";
        } else if (inputselect.equals("Vcustomer")) {
            strTable = "vcustomer";
        } else if (inputselect.equals("Mproduct_type")) {
            strTable = "mproduct_type";
        } else if (inputselect.equals("Vd_rawmatt_receive")) { //-- For Report
            strTable = "vd_rawmatt_receive";
        }else if (inputselect.equals("Lookup")) { //-- For Report
            strTable = "mlookup";
        } else if (inputselect.equals("vm_burn_no") || inputselect.equals("vm_burn_no1") || inputselect.equals("vm_burn_no2") || inputselect.equals("vm_burn_no3")|| inputselect.equals("vm_burn_no4")|| inputselect.equals("vm_burn_no5")
               ||inputselect.equals("vm_burn_no6") || inputselect.equals("vm_burn_no7") || inputselect.equals("vm_burn_no8") || inputselect.equals("vm_burn_no9")|| inputselect.equals("vm_burn_no10")) {
            strTable = "vm_burn_no";            
        }else{
            strTable = inputselect;
        }
        // JOptionPane.showConfirmDialog(null, strTable);
        return strTable;


    }
}
