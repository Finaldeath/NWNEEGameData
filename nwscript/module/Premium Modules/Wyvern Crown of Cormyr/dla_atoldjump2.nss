// November 2005
// B W-Husey
// PC has taken the damsel sidequest. Set the variable and journal appropriately.
#include "cu_functions"
#include "dla_i0_horse"



void main()
{
    object oPC = GetPCSpeaker();
    ExecuteScript("dla_atoldtograve",OBJECT_SELF);
    AllParty("nDamsel",oPC,1);
    AddJournalQuestEntry("Damsel",10,oPC);
    DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker());
    DelayCommand(0.5,AssignCommand(oPC,JumpToObject(GetWaypointByTag("TP_TFEStart"))));
//    DelayCommand(1.0,AssignCommand(oPC, ActionUseFeat(FEAT_DLA_HORSE_PARTY_MOUNT, OBJECT_SELF)));
}
