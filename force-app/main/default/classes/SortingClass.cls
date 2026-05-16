public class SortingClass {
    
    public static void SortingMethod(){
        
        List<Integer> list1 = new list<Integer>{5,4,3,1,2,6};
            
            for (Integer i = 0; i < list1.size(); i++) {
                system.debug('line 8 size---------->'+list1.size());
                
                // system.debug('line 10---------->'+list1);
                for (Integer j = 0; j < list1.size() - 1; j++){
                    system.debug('line 12-------->'+list1);
                    
                    if (list1[j] > list1[j + 1]) {
                        system.debug('line 15-------->'+list1[j]);
                        
                        system.debug('line 17----->'+list1[j + 1]);
                        
                        Integer temp = list1[j];
                        system.debug('line 21------>'+list1[j]);
                        list1[j] = list1[j + 1];
                        system.debug('line 23----->'+list1[j]);
                        system.debug('line ------->'+list1[j+1]);
                        list1[j + 1] = temp;
                        system.debug('line 26------->' +list1[j + 1]);
                    }
                }
            }
        
        System.debug('Sorted List 31 ------>>: ' + list1);
    }
}