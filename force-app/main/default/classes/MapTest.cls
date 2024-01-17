public class MapTest {
    public static void main(){
        Map<String, String> country_Name = new Map<String, String>{'United States' => 'Dollar','Japan' => 'yen','France' => 'Euro','India' => 'Rupee'};
            
        System.debug(country_Name.get('India'));
    }
}