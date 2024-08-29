public with sharing class FutureExample {
    public FutureExample() {

    }

    @future
    public static void executeFutureMethodExample1(){
        System.debug('Executing Future Method Example1');
        for (Integer i = 0; i < 5; i++){
            System.debug('for loop iteration: executeFutureMethodExample1' + i);
        }
    }

    @future
    public static void executeFutureMethodExample2(){
        System.debug('Executing Future Method Example2');
        for (Integer i = 0; i < 5; i++){
            System.debug('for loop iteration: executeFutureMethodExample2' + i);
        }
    }
}