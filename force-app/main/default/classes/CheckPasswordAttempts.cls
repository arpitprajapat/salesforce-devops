// write a method that check the number of attempts made by user for a password input and throw an error 
// if failed attempt axcced 3 
public class CheckPasswordAttempts {
    
    public static string password = 'Indore';  
    public static integer EnterPass = 1;
    
    public static void PassingName(){
        string strreturn = '';
        strreturn = MethodPassword('Indoree');
		system.debug('--line 11--'+strreturn);        
        strreturn = MethodPassword('Indoreq');
        system.debug('--line 13--'+strreturn);
        strreturn = MethodPassword('Indore');
        system.debug('--line 15--'+strreturn);
    }  
    public static string MethodPassword(string PasswordInput){
        system.debug('----'+PasswordInput);
        system.debug('--password--'+password);
        if(PasswordInput != password){
            if( EnterPass > 3){
                system.debug('--line--'+EnterPass);
                return 'you have entered password greater than 3 times';
            }             
            EnterPass = EnterPass+1;
            system.debug('-line 25 Attempt :'+Enterpass);
            return 'failure';      
        }
        else
        {
            return 'success------';   
            
        }    
    }
}