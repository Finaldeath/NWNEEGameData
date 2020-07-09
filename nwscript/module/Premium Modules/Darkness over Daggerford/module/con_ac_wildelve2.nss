//::///////////////////////////////////////////////
//:: FileName con_ac_wildelve2
//:: Have Kyleena go hostile, and set the variable to indicate so
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 3:22:44 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcAttack(object o1, object oPC)
{
object oPC = GetPCSpeaker();
ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE);
SetIsTemporaryEnemy(oPC, o1);
AssignCommand(o1, ActionAttack(oPC));
AssignCommand(o1, DetermineCombatRound(oPC));
}
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"ac_wildelves_quest",2);
    ahcAttack(OBJECT_SELF, oPC);

    int nC = 1;
    object oParty = GetNearestObjectByTag("ac_wildelfguard2", oPC, nC);
    while(GetIsObjectValid(oParty))
    {
    ahcAttack(oParty, oPC);
    nC ++;
    oParty = GetNearestObjectByTag("ac_wildelfguard2", oPC, nC);
    }
    ahcAttack(GetObjectByTag("ac_kyleena"), oPC);
    ahcAttack(GetObjectByTag("ac_wildelfguard"), oPC);
}

