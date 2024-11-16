public with sharing class StringListTest {

    public static List<String> generateStringList(Integer x){
        List<String> stringsList = new List<String>();
        for(Integer i=0; i < x; i++){
            stringsList.add('Test '+i);
        }
        return stringsList;
    }
}