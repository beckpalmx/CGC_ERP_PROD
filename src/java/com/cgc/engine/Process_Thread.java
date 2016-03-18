package com.cgc.engine;

import com.cgc.DB.Process_transaction_wh_summaryDB_New;
import java.util.Random;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class Process_Thread {   

    public String main_check() throws Exception {
        String Return_Str = "";
        startProgress("A");
        startProgress("B");
        startProgress("C");
        return Return_Str;
    }

    public static void startProgress(final String sItem) {

        Runnable runnable = new Runnable() {

            @Override
            public void run() {

                for (int i = 0; i <= 5; i++) {
                    final int value = i;
                    try {
                        Thread.sleep(1);
                    } catch (InterruptedException e) {
                        System.out.println("Error : " + e);
                    }
                    System.out.println("Item Thread " + sItem + " (value = " + value + " )");
                }
            }
        };
        new Thread(runnable).start();
    }

}
