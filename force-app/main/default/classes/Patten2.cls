public class Patten2 {

    public static void patt(){
	integer n=4;
	integer a=1;
	integer j;

    for(integer i=1;i<=n;i++)
    { string s ;
      
        for(integer m=1 ; m<=n-i ; m++)
        {
           s=s+'__' ;
           j=m;
        }
        for(integer k=1;k<=a;k++)
        {
            s=s+'**';
        }
     	for(integer l=a;l<=n;l++){
         s=s+'__' ;
     }
         System.debug(s);
     	 a=a+2;
    }
    }
}