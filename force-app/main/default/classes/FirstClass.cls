public class FirstClass{
    public void firstClass(){

List<integer> intnum = New List<integer>();
intnum.add(1);
intnum.add(543);
intnum.add(435);
intnum.add(34);
intnum.add(233);
intnum.add(234);
intnum.add(235);
intnum.add(237);
intnum.add(773);
intnum.add(53);
intnum.add(63);
intnum.add(73);
intnum.add(83);
intnum.add(43);
intnum.add(45);
intnum.add(32);
integer totalsum=0;
for(integer num : intnum){
    totalsum = totalsum + num;
}
system.debug('Total sum='+totalsum);
    }
}