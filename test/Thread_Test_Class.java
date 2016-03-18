/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author beckpalmx
 */
public class Thread_Test_Class {

    public static void main(String args[]) {
        PrepareProgress("A");
        PrepareProgress("B");
        PrepareProgress("C");
        System.out.println("PrepareProgress" );
    }

    public static void PrepareProgress(String sItem) {
        startProgress(sItem);
        System.out.println("sItem = " + sItem);
    }

    public static void startProgress(final String sItem) {

        Runnable runnable = new Runnable() {

            @Override
            public void run() {

                for (int i = 0; i <= 5; i++) {
                    final int value = i;
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        System.out.println("Error : " + e);
                    }
                    System.out.println("Item Thread " + sItem + " (value = " + value + " )");
                }
                if (sItem.equals("C")) {
                    System.out.println("End Run");
                }

            }
        };
        new Thread(runnable).start();
    }

}
