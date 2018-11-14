global class ScheduledSeasonUpdate implements Schedulable {
    global void execute(SchedulableContext sc) {
        SeasonInfo sInfo = new SeasonInfo(Date.today());
        SeasonRecord sRecord = new SeasonRecord(sInfo);
        sRecord.createSeasonRecords();
    }
}