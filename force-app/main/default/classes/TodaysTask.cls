public class TodaysTask {
    public TodaysTask(){
        takebath();
        takeBreakFast();
        carService();
        EnjoyWithFriend();
    }
    public static void takebath(){
        system.debug('Taking bath');
    }
    @Future 
    public static void takeBreakFast(){
        system.debug('having breakfast');
    }
    public static void carService(){
        system.debug('car reparing');
    }
    public static void EnjoyWithFriend(){
        system.debug('enjoying');
    }
}