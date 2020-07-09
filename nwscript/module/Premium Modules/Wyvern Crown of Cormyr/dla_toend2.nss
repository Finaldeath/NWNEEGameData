//Death/conversation script to trigger the mod end cutscene.

#include "cu_functions"

void main()
{
    location lLoc = GetLocation(GetWaypointByTag("TP_TFPC"));
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    FadeToBlack(oPC,FADE_SPEED_SLOWEST);
    AssignCommand(oPC,ClearAllActions(TRUE));
    BeHappy(oPC);
    SetCutsceneMode(oPC,TRUE);
    DelayCommand(1.5,AssignCommand(oPC,JumpToLocation(lLoc)));
}
