public class BonusTracker{
    
    public static integer BonusGiving (string employee){
        Integer bonusAmount = 25000;
        
        if(employee == '------Manager------'){					// 10,000
            bonusAmount = bonusAmount+5000;
            system.debug('line 8'+bonusAmount);		// 
        }
        else if(employee == '------ Resion head------'){       // 10,000 
            bonusAmount = bonusAmount+10000;
              system.debug('------line 12-----'+bonusAmount);	 // 35,000
        }
        else if(employee == 'svp'){					// 15,000
            bonusAmount = bonusAmount+15000;
              system.debug('-----line 16----'+bonusAmount);   // 40,000
        }
        else if(employee == 'vps'){					// 25,000
            bonusAmount = bonusAmount+20000;
              system.debug('------line 20-----'+bonusAmount);  // 50,000
        }
        else if(employee == 'CTO' || employee == 'Coo' || employee == 'CEO'){  //50,000+25000
            bonusAmount = bonusAmount+30000;
              system.debug('-----line 24----' + bonusAmount); 			// 75,000
        }
        return bonusAmount;
    }

}