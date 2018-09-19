public class SeasonInfo {
    private Integer currentYear;
    private Integer currentMonth;
    
    public SeasonInfo(Date todaysDate) {
        currentYear = todaysDate.year();
        currentMonth = todaysDate.month();
    }
    
    // Get current season record
    public String getCurrentSeasonName() {
        return getSeasonName(0);
    }
    // Returns name of the season
    public String getSeasonName(Integer yearsAgo) {
        // Check if the new season has started
        if (currentMonth >= 11) {
            return (currentYear - yearsAgo) + '-' + (currentYear - 1999 - yearsAgo);
        } else {
            return (currentYear - 1 - yearsAgo) + '-' + (currentYear - 2000 - yearsAgo);
        }
    }
    // Check if a season is still going
    public Boolean isSeasonEnded() {
        return (currentMonth >= 5 && currentMonth <= 10);
    }
    
}