//Drelia opens the door and stats her conversation with the player
void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetObjectByTag("harper_door");
    object oDrelia = GetObjectByTag("db_drelia");
    AssignCommand(oDrelia,ActionOpenDoor(oDoor));
    AssignCommand(oDrelia,ActionStartConversation(oPC));
}
