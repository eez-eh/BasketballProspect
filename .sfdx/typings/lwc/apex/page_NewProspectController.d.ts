declare module "@salesforce/apex/page_NewProspectController.getExternalPlayerID" {
  export default function getExternalPlayerID(param: {fullName: any, team: any}): Promise<any>;
}
declare module "@salesforce/apex/page_NewProspectController.playerCallout" {
  export default function playerCallout(param: {externalId: any}): Promise<any>;
}
declare module "@salesforce/apex/page_NewProspectController.deleteProspect" {
  export default function deleteProspect(param: {externalId: any}): Promise<any>;
}
declare module "@salesforce/apex/page_NewProspectController.gameCallout" {
  export default function gameCallout(param: {externalId: any, playerId: any}): Promise<any>;
}
