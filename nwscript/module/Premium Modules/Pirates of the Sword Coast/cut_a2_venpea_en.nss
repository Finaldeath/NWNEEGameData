//::///////////////////////////////////////////////
//:: PC encounters either Vengaul or Honeypea (end script)
//:: cut_a2_venpea_en.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 7/05
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oSpeaker = GetLocalObject(OBJECT_SELF, "NPC_BANDIT");
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSpeaker);
    AssignCommand(oSpeaker, ActionStartConversation(oPC));
}
