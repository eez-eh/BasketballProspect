global class ScheduledSeasonUpdate implements Schedulable {
    // Make a scheduled callout to create new season records
    global void execute(SchedulableContext sc) {
        SeasonInfo sInfo = new SeasonInfo(Date.today());
        SeasonRecord sRecord = new SeasonRecord(sInfo);
        sRecord.createSeasonRecords();
    }
}