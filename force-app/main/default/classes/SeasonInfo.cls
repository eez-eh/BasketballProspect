public class SeasonInfo {
    private Integer currentYear;
    private Integer currentMonth;
    
    public SeasonInfo(Date todaysDate) {
        currentYear = todaysDate.year();
        currentMonth = todaysDate.month();
    }
    
    public String getCurrentSeasonName() {
        return getSeasonName(0);
    }
    
    public String getSeasonName(Integer yearsAgo) {
        // if it's November, the new season has started
        if (currentMonth >= 11) {
            return (currentYear - yearsAgo) + '-' + (currentYear - 1999 - yearsAgo);
        } else {
            return (currentYear - 1 - yearsAgo) + '-' + (currentYear - 2000 - yearsAgo);
        }
    }
    
    public Boolean isSeasonEnded() {
        return (currentMonth >= 5 && currentMonth <= 10);
    }
    
}