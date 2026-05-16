public class Findnumberclass {
    
    public static void NumberMethod() {
        List<Integer> list1 = new List<Integer>{1, 1, 2, 2, 3, 1, 3};
        Integer count1 = 0;
        Integer count2 = 0;
        Integer count3 = 0;

        for (Integer num : list1) {  
          //  System.debug('Current number in list -> ' + num);            

            if (num == 1) {
                count1++;
            } 
            else if (num == 2) {
                count2++;
            } 
            else if (num == 3) {
                count3++;   
            }       
        }

        System.debug('1 -> ' +count1);
        System.debug('2 -> ' +count1);
        System.debug('3 -> ' +count1);
    }
}