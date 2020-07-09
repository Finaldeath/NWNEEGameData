//Death/conversation script to trigger the mod end cutscene.
#include "cu_functions"
void main()
{
    //debug message
//    SendMessageToPC(GetFirstPC(),"Called final death script of WL");

    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("TP_TFPC"));
    if (GetIsObjectValid(oPC)== FALSE) GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    FadeToBlack(oPC,FADE_SPEED_SLOWEST);
    BeHappy(oPC);
    AssignCommand(oPC,ClearAllActions(TRUE));
    DelayCommand(0.1,AssignCommand(oPC,JumpToLocation(lLoc)));
}
