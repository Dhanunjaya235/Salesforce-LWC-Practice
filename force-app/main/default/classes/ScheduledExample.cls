public with sharing class ScheduledExample implements Schedulable{
    public ScheduledExample(){
    }

    public void execute(SchedulableContext SC){
        Datetime now = Datetime.now();
        Integer offset = UserInfo.getTimezone().getOffset(now);
        Datetime local = now.addSeconds(offset / 1000);
        System.debug('Scheduled Apex Job Running At \t' + local);
    }

}