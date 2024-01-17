public class Patten {

    public static void patt(){
        String s =' ';
        String Temp = '_';
        for (Integer i=5;i>0;i--){
            s = s + '*';
            for(Integer j=0;j<i-1;j++){
                Temp = Temp + '_';
            }
            
            system.debug(Temp+s);
            temp = '_';
        }
    }
}