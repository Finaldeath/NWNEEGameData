// January 2006
// B W-Husey
// PC fails to overpower Latim, dumped on dock, failed quest and access
// to ship prevented. Alignment consequences same as overpowering.
#include "cu_functions"

void main()
{
    object oDoor = GetObjectByTag("TDoorShipIn");
    object wWay = GetWaypointByTag("WP_Dumped");
    object oPC = GetPCSpeaker();
    object oHench = ReturnHenchman(oPC,1);
    AssignCommand(oPC,ClearAllActions());
    DelayCommand(4.0,FadeFromBlack(oPC,FADE_SPEED_SLOW));
    AssignCommand(oPC,JumpToObject(wWay));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,5.0));
    AllParty("nAbduct",oPC,6);                                    //Just sets variable
    AddJournalQuestEntry("Abduct",51,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,2,2,1,2,1,1,2,2,2);            //Who gets alignment points for this
    SetLocked(oDoor,TRUE);
    GiveKnightReputation(oPC,"the Weak");
    if (GetIsObjectValid(oHench)) DelayCommand(5.0,AssignCommand(oHench,ActionStartConversation(oPC,"latim2",FALSE,FALSE)));
}
