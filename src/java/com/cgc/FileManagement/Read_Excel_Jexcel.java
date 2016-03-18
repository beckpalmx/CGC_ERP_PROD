/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.FileManagement;

import java.io.File;
import jxl.Sheet;
import jxl.Workbook;

/**
 *
 * @author Beckpalmx No7
 */
public class Read_Excel_Jexcel {
    public void Read() throws Exception {
        //StringBuffer data = new StringBuffer();
        File fp = new File("D:\\workspace\\CGC_ERP\\Source\\CGC_ERP\\build\\web\\UPLOADS\\File", "Test1.xlsx");//"D:\\workspace\\CGC_ERP\\Source\\CGC_ERP\\build\\web\\UPLOADS\\File","Test1.xls"
        try {
            /*
            //แบบหลายsheet
            String data = null;
            Workbook wb = Workbook.getWorkbook(fp);
            Sheet[] sheet = wb.getSheets();//อ่านที่sheet
            for (int i = 0; i < sheet.length; i++) {
                int columns = sheet[i].getColumns();
                int rows = sheet[i].getRows();
                for (int row = 0; row < rows; row++) {
                    for (int column = 0; column < columns; column++) {
                        data += sheet[i].getCell(column, row).getContents() + " ";
                        //System.out.println(sheet.getCell(column, row).getContents());
                    }
                    System.out.println(data);
                    data = null;
                }
            }*/
            //-------------------------แบบชีตเดียว------------------------------
            String data = null;
            Workbook wb = Workbook.getWorkbook(fp);
            Sheet sheet = wb.getSheet(1);//อ่านที่sheet
            int columns = sheet.getColumns();
            int rows = sheet.getRows();
            for (int row = 0; row < rows; row++) {
                for (int column = 0; column < columns; column++) {
                    data += sheet.getCell(column, row).getContents() + " ";
                    //System.out.println(sheet.getCell(column, row).getContents());
                }
                System.out.println(data);
                data = null;
            }
            //-------------------------แบบชีตเดียว------------------------------
            wb.close();
        } catch (Exception ioe) {
            System.out.printf("Error" + ioe);
        } finally {
            
        }
    }
}
