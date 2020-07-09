//::///////////////////////////////////////////////
//:: FileName con_ac_convo
//:: Initiate convo with PC
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:22:44 PM
//:://////////////////////////////////////////////

#include "x0_i0_position"

location GetFacingLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    float fAngleOpposite = GetOppositeDirection(fDir);
    return GenerateNewLocation(oTarget, DISTANCE_SHORT, fDir, fAngleOpposite);
}

void main()
{
    /*object oPC = GetEnteringObject();
    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
    SetLocalInt(OBJECT_SELF,"fired",1);
    SetCutsceneMode(oPC,TRUE);
    object oD = GetObjectByTag("ac_blackdragon");
    FadeToBlack(oPC, FADE_SPEED_FASTEST);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(1.5, AssignCommand(oPC, JumpToLocation(GetFacingLocation(oD))));
    DelayCommand(1.6, FadeFromBlack(oPC));
    DelayCommand(1.7, AssignCommand(oPC, ActionStartConversation(oD))); */
}
