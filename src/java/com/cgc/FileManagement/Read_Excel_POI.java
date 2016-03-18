/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.FileManagement;

import com.cgc.bean.DataBeanD_data_import_from_excel;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Beckpalmx No7
 */
public class Read_Excel_POI {
//อ่านFile นามสกุล xls

    public void Read_XLS() throws Exception {
        String output = "";
        try (FileInputStream file = new FileInputStream(new File("D:\\workspace\\CGC_ERP\\Source\\CGC_ERP\\build\\web\\UPLOADS\\File", "Test1.xls"))) {
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(1);
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Iterator<Cell> cellIterator = row.cellIterator();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    switch (cell.getCellType()) {
                        case Cell.CELL_TYPE_BOOLEAN:
                            output += Boolean.toString(cell.getBooleanCellValue()) + "\t\t";
                            //System.out.print(cell.getBooleanCellValue() + "\t\t");
                            break;
                        case Cell.CELL_TYPE_NUMERIC:
                            output += Double.toString(cell.getNumericCellValue()) + "\t\t";
                            //System.out.print(cell.getNumericCellValue() + "\t\t");
                            break;
                        case Cell.CELL_TYPE_STRING:
                            output += cell.getStringCellValue() + "\t\t";
                            //System.out.print(cell.getStringCellValue() + "\t\t");
                            break;
                    }
                }
                System.out.println(output);
                output = "";
            }
        } catch (IOException e) {
            System.out.print("error " + e);
        }

    }
    //อ่านFile นามสกุล xlsx

    public void Read_XLSX() throws Exception {
        String output = "";
        try (FileInputStream file = new FileInputStream(new File("D:\\workspace\\CGC_ERP\\Source\\CGC_ERP\\build\\web\\UPLOADS\\File", "Test1.xlsx"))) {
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            XSSFSheet sheet = workbook.getSheetAt(1);
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Iterator<Cell> cellIterator = row.cellIterator();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    switch (cell.getCellType()) {
                        case Cell.CELL_TYPE_BOOLEAN:
                            output += Boolean.toString(cell.getBooleanCellValue()) + "\t\t";
                            System.out.print(cell.getBooleanCellValue() + "\t\t");
                            break;
                        case Cell.CELL_TYPE_NUMERIC:
                            output += Double.toString(cell.getNumericCellValue()) + "\t\t";
                            System.out.print(cell.getNumericCellValue() + "\t\t");
                            break;
                        case Cell.CELL_TYPE_STRING:
                            output += cell.getStringCellValue() + "\t\t";
                            System.out.print(cell.getStringCellValue() + "\t\t");
                            break;
                    }
                }
                System.out.println(output);
                output = "";
            }
        } catch (IOException e) {
            System.out.print("error" + e);
        }
    }

    public ArrayList<DataBeanD_data_import_from_excel> Read_XLS(FileInputStream file, ArrayList<DataBeanD_data_import_from_excel> ObjAL) throws Exception {
        String output = "";
        int number_column_cell = 1, number_row = 1;
        try {
            //InputStream objinputstream = mul.getRequest().getInputStream();
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Iterator<Cell> cellIterator = row.cellIterator();
                DataBeanD_data_import_from_excel DataBean = new DataBeanD_data_import_from_excel();
                while (cellIterator.hasNext()) {
                    Cell cell = cellIterator.next();
                    switch (cell.getCellType()) {
                        case Cell.CELL_TYPE_BOOLEAN:
                            output = Boolean.toString(cell.getBooleanCellValue());
                            break;
                        case Cell.CELL_TYPE_NUMERIC:
                            output = Double.toString(cell.getNumericCellValue());
                            break;
                        case Cell.CELL_TYPE_STRING:
                            output = cell.getStringCellValue();
                            break;
                    }
                    switch (number_column_cell) {
                        case 1:
                            DataBean.setProduct_id(output);
                            break;
                        case 2:
                            DataBean.setWarehouse(output);
                            break;
                        case 3:
                            DataBean.setLocation_id(output);
                            break;
                        case 4:
                            DataBean.setWeight(output);
                            break;
                        case 5:
                            DataBean.setDoc_type(output);
                            break;
                        case 6:
                            DataBean.setName_t(output);
                            break;
                        case 7:
                            DataBean.setPgroup_id(output);
                            break;
                        case 8:
                            DataBean.setPtype_id(output);
                            break;
                        case 9:
                            DataBean.setPcat_id(output);
                            break;
                        case 10:
                            DataBean.setIodine(output);
                            break;
                        case 11:
                            DataBean.setUnit_name(output);
                            break;
                        case 12:
                            DataBean.setWeight_bag(output);
                            break;
                        case 13:
                            DataBean.setDoc_date(output);
                            break;
                        case 14:
                            DataBean.setRemark(output);
                            break;
                        default:
                            break;
                    }
                    output = "";
                    number_column_cell += 1;
                }
                //System.out.println(output);
                number_column_cell = 1;
                ObjAL.add(DataBean);
            }
        } catch (IOException e) {
            e.printStackTrace(System.out);
        } finally {
        }
        return ObjAL;
    }
}
