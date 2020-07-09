// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC grefuses anything more to do with Imelda. Alignment consequences of this are evil aligned though
// letting Hawklin solve his own problems is not that evil as thePC is now independant.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();
    AligXP("AXPHImNo",GetPCSpeaker(),"EVIL",150,0);
    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,4);                                    //Just sets variable
    AddJournalQuestEntry("Revenge",60,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,2,3,3,3,4,4,4,5,5);
}


