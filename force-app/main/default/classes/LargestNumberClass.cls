public class LargestNumberClass{
    
    public static void FindLargestNumber() {
        List<Integer> list1 = new List<Integer>{1, 2, 2, 4, 5};
            
            Integer largestNumber = list1[0]; 
        system.debug('line 7------------> '+largestNumber);
        
        
        for (Integer i = 0; i< list1.size(); i++) {
            if (list1[i] > largestNumber) {
                system.debug('line 10------------> '+list1[i]);
                largestNumber = list1[i];
            }
        }
        
        System.debug('largest number : ' + largestNumber);
    }
}