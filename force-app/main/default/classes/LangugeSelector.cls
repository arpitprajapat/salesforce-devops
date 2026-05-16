public class LangugeSelector {
    
    public static string Language(string CountryLanguage){
        string languageType = 'English';
        string localTocheck = CountryLanguage.tolowercase();
        switch on CountryLanguage{
            when 'Dubai'{
                languageType = 'Uae';
            }
            when 'china'{
                languageType = 'chinese';

            }
            when 'russia'{
                languageType = 'russian';
            }
            when else{
                languageType = 'English';
            }
        }
        return languageType;
    }
}