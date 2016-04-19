
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import com.cgc.DB.DBConnect;

class TZ_RunnableDemoThread implements Runnable {

    private Thread t;
    private final String threadName;
    DBConnect DB = new DBConnect();

    TZ_RunnableDemoThread(String name) {
        //SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        //Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
        //String start_time = sdf.format(cur_time);

        threadName = name;
        //System.out.println("Creating " + threadName + " start_time = " + start_time );
        System.out.println("Creating " + threadName);
    }

    @Override
    public void run() {

        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Timestamp cur_time;
        String start_time;

        System.out.println("Running " + threadName);
        try {

            for (int i = 1; i <= 10; i++) {
                cur_time = new Timestamp(new java.util.Date().getTime());
                start_time = sdf.format(cur_time);
                System.out.println("Thread: " + threadName + ", " + i + " start_time = " + start_time);
                // Let the thread sleep for a while.                
                Thread.sleep(5000);
            }
            
        } catch (InterruptedException e) {
            System.out.println("Thread " + threadName + " interrupted." + e);
        }
        String message = "";
        for (int k = 1; k < 100; k++) {
            //System.out.println("Loop Delay " + k + " " + threadName);
            message += "Loop Delay " + k + " " + threadName;

        }
        cur_time = new Timestamp(new java.util.Date().getTime());
        start_time = sdf.format(cur_time);
        System.out.println("Thread " + threadName + " exiting. Stop Time = " + start_time);
        //System.out.println(message);

    }

    public void start() {
        System.out.println("Starting " + threadName);
        if (t == null) {
            t = new Thread(this, threadName);
            t.start();
        }
    }

    public static void main(String args[]) {

        TZ_RunnableDemoThread R1 = new TZ_RunnableDemoThread("Thread-1");
        R1.start();

        TZ_RunnableDemoThread R2 = new TZ_RunnableDemoThread("Thread-2");
        R2.start();

        TZ_RunnableDemoThread R3 = new TZ_RunnableDemoThread("Thread-3");
        R3.start();

        TZ_RunnableDemoThread R4 = new TZ_RunnableDemoThread("Thread-4");
        R4.start();

    }

}
