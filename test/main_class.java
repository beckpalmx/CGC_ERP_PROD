/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author beckp
 */
import java.sql.Timestamp;

public class main_class {

    public static void main(String[] args) throws Exception {
        startThread("A");
        startThread("B");
        startThread("C");
    }

    public static void startThread(final String name) {
        Runnable runner;
        runner = new Runnable() {
            @Override
            public void run() {
                for (int i = 0; i <= 10; i++) {
                    int value = i;
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        System.out.println(e);
                    }
                    System.out.println("Item Thread " + name + " (value = " + value + " )" + new Timestamp(new java.util.Date().getTime()));
                }
            }
        };
        new Thread(runner).start();
    }

}
