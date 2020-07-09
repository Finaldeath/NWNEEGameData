//::///////////////////////////////////////////////
//:: FileName con_ac_host_gill
//:: NPC speaker and cohorts attack
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/31/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcAttack(object o1, object oPC)
{
    ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(oPC, o1);
    //AssignCommand(o1, ActionAttack(oPC));
    AssignCommand(o1, DetermineCombatRound(oPC));
}
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_sej_bandit", 2);

    ahcAttack(OBJECT_SELF, oPC);

    int iC = 1;
    object oBandit = GetNearestObjectByTag("ac_ghillbandt1", oPC, iC);
    while(GetIsObjectValid(oBandit))
    {
        ahcAttack(oBandit, oPC);
        iC++;
        oBandit = GetNearestObjectByTag("ac_ghillbandt1", oPC, iC);
    }
    AddJournalQuestEntry("j58",2,oPC);
}
