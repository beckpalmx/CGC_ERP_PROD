import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;

public class Task_Process {

    public static void main(String[] args) {

        Timer myTimer;
        myTimer = new Timer();
        myTimer.schedule(new TimerTask() {
            @Override
            public void run() {

                timerTick();

            }
        }, 0, 1000);

    }

    private static void timerTick() {
        
        
        
        Calendar c = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = df.format(c.getTime());
        System.out.println("Time now : " + formattedDate);
        
    }

}
