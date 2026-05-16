public class NumberOfDay {
    
    public static integer PassingvalueMethod(map<string , boolean> WeekDay){
      /*public static integer PassingMap(map<string,boolean> WeekDay = new map<string , boolean>()){
      string str= ' ';
str = weekDay.put('Monday','True');
str = weekDay.put('Tuesday','True');
str = weekDay.put('Wednesday','True');
str = weekDay.put('Thursday','True');
str = weekDay.put('Friday','True');
str = weekDay.put('saturday','True');
system.debug('---WeekDays---'+WeekDay);*/
        
        Integer numOfDays=0;
        for(string CountDay : WeekDay.keyset()){   // monday,T,W,Th,F,S
            system.debug('---CountDay---'+CountDay);            
            
            boolean Days = WeekDay.get(CountDay);
            //system.debug('--Days--'+Days);
            if(Days){
                system.debug('--Days--'+Days);
                numOfDays = numOfDays+1;
            }
        }
        return numOfDays;
    }   
}