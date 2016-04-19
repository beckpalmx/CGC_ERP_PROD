
import java.io.*;

public class Test_JSON {

    public static void main(String args[]) throws IOException {
        BufferedReader str = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Insert Name : ");
        String s = str.readLine();
        System.out.println("Yourname " + s);
    }
}
