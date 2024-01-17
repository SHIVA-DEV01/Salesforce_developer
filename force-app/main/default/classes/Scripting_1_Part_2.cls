public class Scripting_1_Part_2 {
    public static List<Integer> fibonacciSeries(){
        Integer i = 0;
        Integer j = 1;
        Integer m = 1;
        List<Integer> fibo = new List<Integer>();
        for (Integer k=0;k<10;k++){
            if (k==0){
                fibo.add(i);
            }
            else{
                fibo.add(i=j);
            	i = j;
            	j = m;
            	m = i+j;
            }
        }
        System.debug(fibo);
        return fibo;
    }
}