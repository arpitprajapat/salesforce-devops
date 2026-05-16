public class TravelTracker {
    
    public static list<string> ListOfTravelJourney = new list<string>();
    public static void StoreTravelJourney(String TravelJourneyName){
        ListOfTravelJourney.add(TravelJourneyName);   
        system.debug('--------ListOfTravelJourney line 6------------------'+ListOfTravelJourney);    //ListOfTravelJourney -> Us , japan , china , Dubai
    }
    public static list<string> ListOfwishlist = new list<string>();
    public static void Addwishlist (string wishName){
        ListOfwishlist.add(wishName);
        system.debug('-------ListOfwishlist line 11 ---------'+ListOfwishlist);			// wishlist -> Dubai , Thailand
    }
    
    public static Map<string , Integer> MapOfCountriesYear = new map<string , Integer>();
    
    public static void VisitedCountriesYear(string Countries , integer Year){
        //MapOfCountriesYear.put(Countries , Year );
        //system.debug('-MapOfCountriesYear VisitedCountries '+MapOfCountriesYear);      // MapOfCountriesYear ->> Us => 2016 , Japan => 2018
        if(!MapOfCountriesYear.containsKey(Countries)){                                                // MapOfCountriesYear US -1
            MapOfCountriesYear.put(Countries,1);		
            system.debug('----------------line 20----------'+MapOfCountriesYear);
        }else{
            system.debug('----Countries--'+Countries);
            system.debug('----Year--'+Year);
            system.debug('-MapOfCountriesYear map line 23 -------'+MapOfCountriesYear);
            Integer noOfTimeVisit = MapOfCountriesYear.get(Countries);
            
            system.debug('--------- noOfTimeVisit line 25 ----------------'+noOfTimeVisit);  // Null
            
            MapOfCountriesYear.put(Countries, noOfTimeVisit+1);
            
            system.debug('----------- MapOfCountriesYear  line 29 ---------------'+MapOfCountriesYear);    
        }
        
        for( string mapOfCounYear : MapOfCountriesYear.keyset()){
            system.debug(' ---------------- mapOfCounYear  line 33 ------------------- '+mapOfCounYear);   // Japan
            system.debug('----------------- keyset -------------------------'+MapOfCountriesYear);
            
            Integer GetKey = MapOfCountriesYear.get('Japan');
            system.debug('----------------------GetKey line 37------------'+GetKey);                    // 1
            
        } 	
        
    }
    public static Map<string , Integer> StoreCountOfTheNumber = new Map<string , Integer>();
    public static void CountTimeOfVisitedCountries(string VisitedCountries , Integer NumberOfTimes){
        
        
        StoreCountOfTheNumber.put(VisitedCountries , NumberOfTimes);
        system.debug('-StoreCountOfTheNumber-'+StoreCountOfTheNumber);       
        
        
    }
}