// November 2005
// B W-Husey
// PC has taken the damsel sidequest. Set the variable and journal appropriately.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    ExecuteScript("dla_atoldtograve",OBJECT_SELF);
    AllParty("nDamsel",oPC,1);
    AddJournalQuestEntry("Damsel",10,oPC);
    AssignCommand(oPC,JumpToObject(GetWaypointByTag("TP_TFEStart")));
}
