
/**
 * @author Crunchify.com
 */
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.Timestamp;
import java.util.Date;

public class json_util {

    public static void main(String[] args) {

        String jsonString = callURL("http://cdn.crunchify.com/wp-content/uploads/code/jsonArray.txt");
        //System.out.println("\n\njsonString: " + jsonString);

        java.util.Date date = new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));

        int x[] = new int[31];
        int x_sum[] = new int[31];
        x[1] = 5;
        x[2] = 5;
        x[3] = 1;
        x[4] = 0;
        x[5] = 5;
        x[6] = 5;
        int d_sum = 0;

        for (int i = 1; i <= 6; i++) {
            d_sum += (x[i]);
            x_sum[i] = d_sum;
            //System.out.print("loop x[" + i + "] = " + x[i] +  "> d_sum = " + d_sum + " | ");
            System.out.println("loop x_sum[" + i + "] = " + x_sum[i] + " X ");
        }

        int at[] = new int[10]; //ประกาศ อาเรย์ ชนิด int ขนาด 10 ตำแหน่ง
        int sum = 0; //ใช้เก็บผลรวม
        double avg; //เก็บค่าเฉลีย

        for (byte i = 0; i < at.length; i++) {
            at[i] = (int) (Math.random() * 99 + 1);// กำหนดให้ at ณ ที่ตำแหน่ง i รับตัวเลขจากการสุ่มค่า
            sum += at[i]; // ให้ sum บวก at[i] แล้วให้ sum เท่ากับค่าที่ sum+at[i]
            //System.out.println("*** sum = " + sum );
        }
        avg = (double) sum / at.length; //
        for (byte j = 0; j < at.length; j++) {
            //System.out.println("Array[" + j + "] = " + at[j]);
        }
        //System.out.println("******************");
        //System.out.println("Total = " + sum);
        //System.out.println("Average = " + avg);

// Replace this try catch block for all below subsequent examples
        try {
            JSONArray jsonArray = new JSONArray(jsonString);
            //System.out.println("\n\njsonArray: " + jsonArray);
        } catch (JSONException e) {
            e.printStackTrace(System.out);
        }
    }

    public static String callURL(String myURL) {
        //System.out.println("Requested URL:" + myURL);
        StringBuilder sb = new StringBuilder();
        URLConnection urlConn;
        InputStreamReader in;
        try {
            URL url = new URL(myURL);
            urlConn = url.openConnection();
            if (urlConn != null) {
                urlConn.setReadTimeout(60 * 1000);
            }
            if (urlConn != null && urlConn.getInputStream() != null) {
                in = new InputStreamReader(urlConn.getInputStream(),
                        Charset.defaultCharset());
                BufferedReader bufferedReader = new BufferedReader(in);
                if (bufferedReader.readLine() != null) {
                    int cp;
                    while ((cp = bufferedReader.read()) != -1) {
                        sb.append((char) cp);
                    }
                    bufferedReader.close();
                }
            }
            //in.close();
        } catch (IOException e) {
            throw new RuntimeException("Exception while calling URL:" + myURL, e);
        }

        return sb.toString();
    }

}
