public class ApplicationService {

    public static void validateApplications(List<Application__c> applications) {

        for (Application__c app : applications) {

            if (app.Student__c == null) {
                app.addError('Please select a Student.');
            }

            if (app.Job__c == null) {
                app.addError('Please select a Job.');
            }

            if (String.isBlank(app.Status__c)) {
                app.addError('Please select an Application Status.');
            }

            if (app.Application_Date__c == null) {
                app.addError('Please enter the Application Date.');
            }
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getEligibleJobs() {

        return [
            SELECT Id,
                   Name,
                   Company__c,
                   Minimum_CGPA__c,
                   Closing_Date__c
            FROM Job__c
            WHERE Closing_Date__c >= :Date.today()
            ORDER BY Closing_Date__c ASC
        ];
    }

    @AuraEnabled
    public static Id submitApplication(Id jobId) {

        if (jobId == null) {
            throw new AuraHandledException('Please select a job.');
        }

        // Get a student record
        List<Student__c> students = [
            SELECT Id, Name, CGPA__c
            FROM Student__c
            LIMIT 1
        ];

        if (students.isEmpty()) {
            throw new AuraHandledException(
                'No student record was found.'
            );
        }

        Student__c student = students[0];

        // Get selected job
        List<Job__c> jobs = [
            SELECT Id,
                   Name,
                   Company__c,
                   Minimum_CGPA__c,
                   Closing_Date__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        if (jobs.isEmpty()) {
            throw new AuraHandledException(
                'Job not found.'
            );
        }

        Job__c job = jobs[0];

        // Check closing date
        if (job.Closing_Date__c != null &&
            job.Closing_Date__c < Date.today()) {

            throw new AuraHandledException(
                'Application deadline has passed for this job.'
            );
        }

        // Check CGPA
        if (job.Minimum_CGPA__c != null &&
            student.CGPA__c != null &&
            student.CGPA__c < job.Minimum_CGPA__c) {

            throw new AuraHandledException(
                'You are not eligible for this job. Required CGPA: ' +
                String.valueOf(job.Minimum_CGPA__c)
            );
        }

        // Check duplicate application
        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :student.Id
            AND Job__c = :jobId
            LIMIT 1
        ];

        if (!existingApplications.isEmpty()) {
            throw new AuraHandledException(
                'You have already applied for this job.'
            );
        }

        // Create application
        Application__c application = new Application__c(
            Student__c = student.Id,
            Job__c = job.Id,
            Status__c = 'Applied',
            Application_Date__c = Date.today()
        );

        insert application;

        return application.Id;
    }
}
