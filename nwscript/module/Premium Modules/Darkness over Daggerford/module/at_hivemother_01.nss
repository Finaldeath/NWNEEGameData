// the hive mother and her friends attack the player

#include "NW_I0_GENERIC"

void GoHostile(object oNPC, object oPC)
{
    SetPlotFlag(oNPC, FALSE);
    SetImmortal(oNPC, FALSE);
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, ActionAttack(oPC));
    DetermineCombatRound(oPC);

}

void main()
{
    object oPC = GetPCSpeaker();

    // spiders go hostile
    int i = 1;
    object oGuard = GetNearestObjectByTag("_spiderguard", OBJECT_SELF, i);
    while (GetIsObjectValid(oGuard))
    {
        GoHostile(oGuard, oPC);
        oGuard = GetNearestObjectByTag("_spiderguard", OBJECT_SELF, ++i);
    }
    GoHostile(OBJECT_SELF, oPC);

    // don't generate any more young ones
    SetLocalInt(GetArea(OBJECT_SELF), "nLittleSpidersAttacked", 1);
}
