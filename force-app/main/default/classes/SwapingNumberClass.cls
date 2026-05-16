public class SwapingNumberClass {
    
    public static void SwapMethod(){
        
        Integer a = 10;
        Integer b = 20;
        Integer Temp;
        
        system.debug('before swapping a is : '+a);
        system.debug('before swapping b is : '+b);
        
        Temp = a;
        a = b;
        b = Temp;
        
        system.debug('after swapping a is : '+a);
        system.debug('after swapping b is : '+b);
        
    }
    
}