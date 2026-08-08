public with sharing class ApplicationController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {
        return ApplicationService.getEligibleJobs();
    }

    @AuraEnabled
    public static Id submitApplication(Id jobId) {
        return ApplicationService.submitApplication(jobId);
    }
}
