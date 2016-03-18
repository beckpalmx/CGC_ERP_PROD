
// Java String split example.
// This Java String split example describes how Java String is split into multiple
// Java String objects.
//

public class unit_test {

    public static void main(String args[]) {
        
        
        
        /*
         Java String class defines following methods to split Java String object.
         String[] split( String regularExpression )
         Splits the string according to given regular expression.
         String[] split( String reularExpression, int limit )
         Splits the string according to given regular expression. The number of resultant
         substrings by splitting the string is controlled by limit argument.
         */

        /* String to split. */
        String str = ",'C-201406-CA50-3','C-201410-0830-6','C-201501--200-3','C-207-CO-5010-4','C-AW1000-2050-6','C-AW1050-2040-4','C-AW1050-2040-6','C-AW1051-8325-4','C-AW1100-0830-6','C-AW1100-1230-6','C-AW1100-4080-6','C-AW1100-5150-6','C-CGC-30-3060-6','C-CGC000-2560-5','C-CGC11A-0408-4','C-CGC11A-0816-4','C-CGC120-0408-4','C-CGC16B-8325-4','C-CGC900--200-4','C-CGCB33-0408-6','C-CY1101-1230-K','C-GW-AW2-0830-6','C-GW0000-1235-6','C-HR1000-1240-6','C-I0801A-0+30-K','C-I0801A-00+6-K','C-I0801A-0830-4','C-I0851A-00+4-4','C-I0851A-0408-4','C-I0851A-0830-4','C-I0900A--325-K','C-I0900A-0816-4','C-I0900A-3060-4','C-I0901A-00+4-4','C-I0901A-0408-4','C-I0901A-0830-4','C-I0901A-3060-K','C-I0901A-6020-4','C-I0951A--100-4','C-I0951A--200-4','C-I0951A-0-16-4','C-I0951A-0-40-4','C-I0951A-0-60-4','C-I0951A-0+50-4','C-I0951A-00+4-4','C-I0951A-0408-3','C-I0951A-0408-4','C-I0951A-0830-4','C-I0951A-1240-4','C-I0951A-5010-4','C-I1000A-00+4-4','C-I1000A-00+4-6','C-I1000A-2050-4','C-I1001A--200-4','C-I1001A-0-16-4','C-I1001A-0+50-4','C-I1001A-00+4-4','C-I1001A-00+8-4','C-I1001A-0408-4','C-I1001A-0830-4','C-I1001A-1240-4','C-I1051A--150-4','C-I1051A--200-4','C-I1051A-+120-K','C-I1051A-0-16-4','C-I1051A-0-40-4','C-I1051A-0+20-4','C-I1051A-00+4-4','C-I1051A-0408-4','C-I1051A-0830-4','C-I1051A-6020-4','C-I1051A-6020-K','C-I1051A-8200-K','C-I1051M-6020-K','C-I1101A--150-4','C-I1101A-0-30-4','C-I1101A-0-80-4','C-I1101A-0+50-4','C-I1101A-00-8-4','C-I1101A-00+4-4','C-I1101A-0408-4','C-I1101A-0830-4','C-I1101A-1230-4','C-I1101A-3070-4','C-I1101A-3070-6','C-I1101A-4014-4','C-I1101A-4080-4','C-I1101A-5015-4','C-I1101A-8200-K','C-I1101A-8325-4','C-I1101M-1230-K','C-I1101M-3070-K','C-I1150A-4580-6','C-I1151A--150-4','C-I1151A-0-30-4','C-I1151A-00-8-4','C-I1151A-00+4-4','C-I1151A-00+4-K','C-I1151A-0408-4','C-I1151A-0408-5','C-I1151A-0830-4','C-I1151A-4580-4','C-I1200A-3570-6','C-I1200A-3570-K','C-I1200A-8325-6','C-I1201A--325-4','C-I1201A-00-8-4','C-I1201A-00+4-4','C-I1201A-0408-4','C-I1201A-0830-4','C-I1201A-3570-4','C-I1201A-6020-4','C-I1201A-8325-4','C-I1250A-5014-4','C-I1251A-00+4-4','C-I1251A-0408-4','C-I1251A-0830-4','C-I1251A-3060-6','C-I1251A-6020-4','C-I1300A-1220-K','C-I1301A-00-8-4','C-I1301A-00+4-3','C-I1301A-0408-3','C-I1301A-2560-K','C-I1350A--325-K','C-I1350A--400-K','C-I1350A-1220-3','C-I1351A-0408-3','C-I1430A-2560-5','C-I1451A-0408-3','C-I1451A-0830-3','C-I1501A-0408-3','C-I1501A-0430-3','C-I1551A-0408-3','C-ID1250-5014-4','C-ID1250-5032-4','C-ID950A-0816-4','C-M-900A-0816-4','C-OLC-LC-1230-6','C-PC-900--325-6','C-PHO-50-5010-4','C-PHO500-6020-4','C-R0751A-0-30-K','C-R0751A-0-40-K','C-R0751A-00-6-K','C-R0800A-RL01-K','C-R0901A-0830-K','C-R0951A-0830-K','C-R1001A-00-8-K','C-R1001A-00+4-K','C-R1001A-0408-K','C-R1001A-0830-K','C-R1051A-00+4-K','C-R1051A-0408-K','C-R1101A-00+4-K','C-R1101A-0408-K','C-R1151A-00+4-K','C-R1151A-0408-K','C-R1201A-00-8-K','C-R1201A-00+4-K','C-R1201A-0408-K','C-R1251A-00-8-K','C-R1251A-00+4-K','C-R1251A-0408-K','C-R1301A-00-8-K','C-R1351A-0+30-K','C-R1351A-00-8-K','C-R1401A-0+30-K','C-R1451A-00-8-K','C-SC2-M0-3070-4','C-SC2-MA-3070-6','C-T0751A-0-30-4','C-T0800A-DUST-3','C-TP-460-0460-6','C-Z00000-DUST-4','C-Z0851A-DUST-4','C-Z0901A-DUST-4','C-Z0951A-DUST-4','C-Z1001A-DUST-4','C-Z1051A-DUST-4','C-Z1101A-DUST-4','C-Z1151A-DUST-4','C-Z1201A-DUST-4','C-Z1251A-DUST-4','P-I1001A-00+8-K','P-I1051A-00+8-K','U-CGC+30-0+30-5','U-I1001A-0+30-K','U-I1100A-0+30-K','U-I1101A-0+30-0','U-R1251A-0+30-K','U-R1301A-0+30-K','U-R1401A-0+30-K','U-R1501A-0+30-K'";
        String[] temp;

        /* delimiter */
        String delimiter = ",";
        /* given string will be split by the argument delimiter provided. */
        temp = str.split(delimiter);
        /* print substrings */
        for (int i = 1; i < temp.length; i++) {
            System.out.println("No. " + i + " : " +  temp[i]);
        }

        System.out.println("temp.length = " + (temp.length-1));

    }

}
