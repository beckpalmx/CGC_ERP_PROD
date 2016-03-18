
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Process_transaction_schedule {

    public static void main(String[] args) {
        // run in a second
        final long timeInterval = 100000;

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                while (true) {

                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    Date date = new Date();
                    System.out.println(dateFormat.format(date));

                    // ------- code for task to run
                    //System.out.println("Hello !!");
                    // ------- ends here
                    try {
                        Thread.sleep(timeInterval);
                    } catch (InterruptedException e) {
                        e.printStackTrace(System.out);
                    }
                }
            }
        };
        Thread thread = new Thread(runnable);
        thread.start();
    }
}
