trigger AccountAddressTrigger on Account (before insert,before update) {
    
    if(Trigger.isBefore){
        AccountTriggerHandler.AddressMatch(Trigger.New);
    }

}