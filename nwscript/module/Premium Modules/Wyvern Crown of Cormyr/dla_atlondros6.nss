// B W-Husey
// September 2005
// Londro Sidequest variable set to 6. Set on Mander conversation.
// Matron has given a written doc that must be witnessed by Mander, who has done so.
// Journal state set to 28 (this script is actually on Mander)
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
    AllParty("LondroSide",oPC,6);
    AddJournalQuestEntry("TheApprenticeSlave",28,oPC,TRUE);
}
