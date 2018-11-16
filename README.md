# Basketball Prospect Project
This application can be used to track information about nba players: their bio profile and season by season statistics. The data is obtained by querying the external database [Stats NBA](https://stats.nba.com). The repository also includes all test classes that provide code coverage for deploying to production.
The UML diagram below shows classes and relationship between them in the application.

![UML](https://raw.githubusercontent.com/eez-eh/BasketballProspect/master/images/uml.jpg)
## Usage
The basic functionality of the application is presented below.
### Create list of prospects
The application performs a query to an external database, retrieves information about currently active players, and creates custom object records on the Salesforce platform. Each record contains only basic information which allow to unambiguously identify the player. This list can be refreshed manually by clicking the button, or by scheduled Apex Job.

![Get List of Prospects](https://raw.githubusercontent.com/eez-eh/BasketballProspect/master/images/refresh_prospects_list.gif)
### Create player profile to track
Any choosen player from the list of potential prospects can be tracked more closely. After selecting the player from drop-down list a query is made to an external database, and the downloaded information is used to create a new Player__c record and Game__c records that reflect statistics from all the games performed by the player over the last 5 years.
Records created in this way are displayed on the customized page layout using Lightning Components. There you can find detailed information about the player's record and his performances in the selected meeting or throughout the whole season.

![Add a Player](https://raw.githubusercontent.com/eez-eh/BasketballProspect/master/images/add_player.gif)
### Refresh Games Button
This button allows to manually download the latest information about the player's recent performances.

![Refresh Games Button](https://raw.githubusercontent.com/eez-eh/BasketballProspect/master/images/refresh_games.gif)
