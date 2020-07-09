#include "NW_I0_GENERIC"

void main()
{
    int h = 1;
    object oDragon = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    ChangeToStandardFaction(oDragon,STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(oPC, oDragon);
    DetermineCombatRound(oPC);
    object oHench = GetHenchman(oPC, h);

    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench,DetermineCombatRound(oDragon));
        h++;
        oHench = GetHenchman(oPC, h);
    }
}
