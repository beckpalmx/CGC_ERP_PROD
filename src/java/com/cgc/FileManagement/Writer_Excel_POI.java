/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.FileManagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Beckpalmx No7
 */
public class Writer_Excel_POI {

    public void Writer_XLS(HttpServletResponse response) throws Exception {
        try {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet("Sample sheet");

            Map<String, Object[]> data = new HashMap<String, Object[]>();
            data.put("1", new Object[]{"Emp No.", "Name", "Salary"});
            data.put("2", new Object[]{1d, "John", 1500000d});
            data.put("3", new Object[]{2d, "Sam", 800000d});
            data.put("4", new Object[]{3d, "Dean", 700000d});
            //data.
            Set<String> keyset = data.keySet();
            int rownum = 0;
            for (String key : keyset) {
                Row row = sheet.createRow(rownum++);
                Object[] objArr = data.get(key);
                int cellnum = 0;
                for (Object obj : objArr) {
                    Cell cell = row.createCell(cellnum++);
                    if (obj instanceof Date) {
                        cell.setCellValue((Date) obj);
                    } else if (obj instanceof Boolean) {
                        cell.setCellValue((Boolean) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof Double) {
                        cell.setCellValue((Double) obj);
                    }
                }
            }
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment; filename=\"Excell.xls\"");
            response.setBufferSize(1024);
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
        } finally {
        }
    }

    public void Writer_XLSX(HttpServletResponse response) throws Exception {
        try {
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Sample sheet");

            Map<String, Object[]> data = new HashMap<String, Object[]>();
            data.put("1", new Object[]{"Emp No.", "Name", "Salary"});
            data.put("2", new Object[]{1d, "John", 1500000d});
            data.put("3", new Object[]{2d, "Sam", 800000d});
            data.put("4", new Object[]{3d, "Dean", 700000d});

            Set<String> keyset = data.keySet();
            int rownum = 0;
            for (String key : keyset) {
                Row row = sheet.createRow(rownum++);
                Object[] objArr = data.get(key);
                int cellnum = 0;
                for (Object obj : objArr) {
                    Cell cell = row.createCell(cellnum++);
                    if (obj instanceof Date) {
                        cell.setCellValue((Date) obj);
                    } else if (obj instanceof Boolean) {
                        cell.setCellValue((Boolean) obj);
                    } else if (obj instanceof String) {
                        cell.setCellValue((String) obj);
                    } else if (obj instanceof Double) {
                        cell.setCellValue((Double) obj);
                    }
                }
            }
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment; filename=\"Excell.xlsx\"");
            response.setBufferSize(1024);
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
        } finally {
        }
    }

    public void Writer_XLS_D_data_import_from_excel(HttpServletResponse response, Connection con) throws Exception {
        ResultSet rs = null;
        String SQL;
        SimpleDateFormat dateformat = new SimpleDateFormat("yyMMdd_HHmmss");
        String[] show_column_product = new String[]{"product_id", "name_t", "pgroup_id", "ptype_id", "pcat_id", "sub_iodine", "unit_id", "unit_name"};
        String[] show_column_warehouse = new String[]{"wh_in"};
        try {
            HSSFWorkbook workbook = new HSSFWorkbook();
            for (int i = 1; i <= 2; i++) {
                HSSFSheet sheet = workbook.createSheet(i == 1 ? "Not Product" : "Not Warehouse");
                int rownum = 0;
                SQL = i == 1
                        ? "select d_data_import_from_excel.product_id,d_data_import_from_excel.name_t,d_data_import_from_excel.pgroup_id,d_data_import_from_excel.ptype_id,d_data_import_from_excel.pcat_id,d_data_import_from_excel.unit_name,d_data_import_from_excel.weight_bag,trim(substring(name_t from '%I#\"%#\"' for '#'))as sub_iodine,(select munit_code.unit_id from munit_code where munit_code.name_t = d_data_import_from_excel.unit_name and munit_code.delete_flag = 'N') as unit_id  from d_data_import_from_excel where (select mproduct.name_t from mproduct where  mproduct.product_id = d_data_import_from_excel.product_id and mproduct.delete_flag = 'N') is null group by product_id,name_t,pgroup_id,ptype_id,pcat_id,iodine,unit_name,weight_bag,sub_iodine order by product_id,pgroup_id"
                        : "select d_data_import_from_excel.wh_in from d_data_import_from_excel where (select mwarehouse.name_t from mwarehouse where  mwarehouse.warehouse_id = d_data_import_from_excel.wh_in and mwarehouse.delete_flag = 'N') is null group by wh_in order by wh_in";
                rs = con.createStatement().executeQuery(SQL);
                Row rowheader = sheet.createRow(rownum++);
                int cellnum = 0;
                for (int loop = 0; loop < ((i == 1)? show_column_product.length:show_column_warehouse.length); loop++) {
                    Cell cell_header = rowheader.createCell(cellnum++);
                    cell_header.setCellValue(((i == 1)?show_column_product[loop]:show_column_warehouse[loop]));
                }
                while (rs.next()) {
                    Row row = sheet.createRow(rownum++);
                    cellnum = 0;
                    switch (i) {
                        case 1:
                            for (int loop = 0; loop < show_column_product.length; loop++) {
                                Cell cell = row.createCell(cellnum++);
                                cell.setCellValue(rs.getString(show_column_product[loop]));
                            }
                            break;
                        case 2:
                            for (int loop = 0; loop < show_column_warehouse.length; loop++) {
                                Cell cell = row.createCell(cellnum++);
                                cell.setCellValue(rs.getString(show_column_warehouse[loop]));
                            }
                            break;
                    }


                }
            }
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment; filename=\"Excell" + dateformat.format(new Date()) + ".xls\"");
            response.setBufferSize(1024);
            workbook.write(response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
    }
}
