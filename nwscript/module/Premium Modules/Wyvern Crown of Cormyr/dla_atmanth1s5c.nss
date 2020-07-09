// B W-Husey
// December 2005
// PC has reported back to Manthia with an oath doc.

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();
object oOath = GetObjectByTag("HuntcrownsOath");

//    ActionGiveItem(oItem,oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);

    CreateItemOnObject("centaurgloves",oPC);

    // Remove from the player
    SetPlotFlag(oOath,FALSE);
    DestroyObject(oOath);

    //Set variable for PC or partywide
AllParty("nManthia1Side",oPC,5);
AddJournalQuestEntry("Centaur",40,oPC);
PartyGotEntry("Null",oPC,500,"XP Gain - Quest completed");

}





