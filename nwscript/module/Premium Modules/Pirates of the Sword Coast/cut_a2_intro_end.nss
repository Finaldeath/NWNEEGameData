//::///////////////////////////////////////////////
//:: Act 2 intro cutscene (end script)
//:: cut_a2_intro_end.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    At the end of the cutscene, Vantabular should
    init dialogue with the nearest PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 7/05
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oVantabular = GetObjectByTag("a2_vantabular");
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oVantabular);
    AssignCommand(oVantabular, ActionStartConversation(oPC));

    object oWP_Garm_2 = GetObjectByTagInArea("cs_wp_intro_garm2");
    object oRealGarm = GetObjectByTagInArea("a1_hench_garm");
    AssignCommand(oRealGarm, ClearAllActions(TRUE));
    AssignCommand(oRealGarm, JumpToObject(oWP_Garm_2));
}
