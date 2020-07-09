//::///////////////////////////////////////////////
//:: FileName con_ac_plagueq2
//:: Have Daxiong and zombies go hostile, and set the variable to indicate so
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 3:22:44 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    object oProtoA =GetObjectByTag("ac_proto234a");
    object oProtoB =GetObjectByTag("ac_proto234b");

    SetLocalInt(GetPCSpeaker(),"ac_plague_quest",2);
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    SetPlotFlag(oProtoA, FALSE);
    SetImmortal(oProtoA, FALSE);
    ChangeToStandardFaction(oProtoA, STANDARD_FACTION_HOSTILE);
    SetPlotFlag(oProtoB, FALSE);
    SetImmortal(oProtoB, FALSE);
    ChangeToStandardFaction(oProtoB, STANDARD_FACTION_HOSTILE);
    DetermineCombatRound();
    AssignCommand(oProtoA, DetermineCombatRound(GetNearestEnemy()));
    AssignCommand(oProtoB, DetermineCombatRound(GetNearestEnemy()));
}
