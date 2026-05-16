// Write a method that takes the list of strings and input and return the count of the number of vowels in each string as result
public class VowelCounter {
    
    public static list<string>VowelList = new list<string>{'a','i','e','o','u'};
        
        public static list<integer>CountVowel(list<string>sentance){
            for(string count : sentance){
                system.debug(' ---- line 8 count ----'+count);
                if(VowelList.size()== 5){
                    integer VowelCount = count.tolowercase().countmatches(VowelList[0])
                        +count.tolowercase().countmatches(VowelList[1])      
                        +count.tolowercase().countmatches(VowelList[2])
                        +count.tolowercase().countmatches(VowelList[3])
                        +count.tolowercase().countmatches(VowelList[4]);
                    system.debug('----VowelCount----'+VowelCount);
                }
            }
            return new list<integer>{0};
                
                }
}