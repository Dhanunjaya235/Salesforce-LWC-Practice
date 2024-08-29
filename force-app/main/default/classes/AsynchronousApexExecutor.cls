public with sharing class AsynchronousApexExecutor{
    public AsynchronousApexExecutor(){
    }

    @AuraEnabled
    public static ID executeQueuableExample(){
        System.debug('Executing Queuable Example');
        ID jobId = System.enqueueJob(new QueueableExample());
        return jobId;
    }

    @AuraEnabled
    public static void executeFutureMethodExample1(){
        FutureExample.executeFutureMethodExample1();
    }

    @AuraEnabled
    public static void executeFutureMethodExample2(){
        FutureExample.executeFutureMethodExample2();
    }

    @AuraEnabled
    public static ID executeScheduledExample(String cronExp, String jobName){
        try{
            // Schedule the job
            String jobId = System.schedule(jobName, cronExp, new ScheduledExample());
            System.debug('Scheduled job ID: ' + jobId);
            return jobId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}