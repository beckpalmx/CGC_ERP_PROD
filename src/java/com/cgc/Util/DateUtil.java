package com.cgc.Util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    public static String Return_Date_Now_full() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        //System.out.println("format.format(date) = " + format.format(date));
        return format.format(date);
    }

    public static String Return_Month_Now() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("MM");
        //System.out.println("format.format(date) = " + format.format(date));
        return format.format(date);
    }

    public static String Return_Year_Now() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyyy");
        //System.out.println("format.format(date) = " + format.format(date));
        return format.format(date);
    }

    public static String ThaiDate_To_EngDate(String date_input) {
        String date_return;
        date_return = Integer.toString(Integer.parseInt(date_input.substring(6, 10)) - 543) + "-" + date_input.substring(3, 5) + "-" + date_input.substring(0, 2);
        //System.out.println("date_return = " + date_return);   
        return date_return;
    }

    public static String ThaiDate_To_ThaiDate(String date_input) {
        String date_return;
        date_return = Integer.toString(Integer.parseInt(date_input.substring(6, 10))) + "-" + date_input.substring(3, 5) + "-" + date_input.substring(0, 2);
        //System.out.println("date_return = " + date_return);        
        return date_return;
    }

}
