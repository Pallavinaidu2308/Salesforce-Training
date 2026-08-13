public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getJobs() {

        return [
            SELECT Id,
                   Name,
                   Company__c,
                   Minimum_CGPA__c,
                   Closing_Date__c
            FROM Job__c
            ORDER BY Closing_Date__c ASC
        ];
    }
}
