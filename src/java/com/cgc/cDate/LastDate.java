/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.cDate;

/**
 *
 * @author witsanu injabok
 */
public class LastDate {
   

    public int LastDate(int varMonth, int varYear) {
        //Calendar calendar = Calendar.getInstance();
        //System.out.println("RECIVE Month = " + varMonth + "  RECIVE Year = " + varYear);
        int year = 0;
        int month = 0;
        year = varMonth;
        month = varYear;
        int mapLastDay = 0;
        // คำนวนหากลุ่มเดือน 31 วัน
        switch (varMonth) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                mapLastDay = 31;
                break;
            // กลุ่มเดือน 30 วัน
            case 4:
            case 6:
            case 9:
            case 11:
                mapLastDay = 30;
                break;
            case 2:
                // กรณีเป็นเดือนกุมภาพันธ์ คำนวนหาปีอนุธิน
                if (0 == varYear % 4 && 0 != varYear % 100 || 0 == varYear % 400) {
                    mapLastDay = 29;
                } else {
                    mapLastDay = 28;
                }
                break;
        }
        return mapLastDay;
    } 
}
