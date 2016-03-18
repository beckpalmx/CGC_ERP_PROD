
public class Test_Date {

    public static void main(String[] args) {
        Test_SubString();
    }

    private static void Test_SubString() {
        String date_from = "01-12-2558";
        String date_to = "31-12-2558";

        int day = Integer.parseInt(date_to.substring(0, 2));
        int month = Integer.parseInt(date_to.substring(3, 5));
        int year = Integer.parseInt(date_to.substring(6, 10)) - 543;

        long diffMinutes = 156000 / (60 * 1000) % 60;
        long add_minutes = (156000 / (60 * 1000) % 60) + 1 ;

        System.out.println("add_minutes = " + add_minutes);

        //System.out.println("Date To = " + day + " : " + month + " : " + year);
    }

}
