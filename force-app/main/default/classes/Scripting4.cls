public class Scripting4 {
    public static List<Product2> createProduct(){
        List<String> fm = new List<String>{'electrical','Cloths','Footwear','utensils','fruits'};
        List<Product2> proList = new List<Product2>();
        for(Integer i=0;i<5;i++){
            Product2 pro = new Product2();
            pro.Name = 'Product '+ i;
            pro.Family = fm.get(i);                
            pro.Description = 'Buy this Product '+ fm.get(i);
            proList.add(pro);
            
        }
        insert proList;
        
        return proList;
    }
}