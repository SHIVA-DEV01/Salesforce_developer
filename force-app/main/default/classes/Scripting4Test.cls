@isTest
public class Scripting4Test {

    @isTest
    public static void createProductTest(){
        List<Product2> proList = Scripting4.createProduct();
        System.assert(proList.size()>0);
    }
}