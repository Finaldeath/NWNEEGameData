#include "NW_I0_GENERIC"
#include "rb_include"

void main()
{
    object oDragon = OBJECT_SELF;

    if (GetCurrentHitPoints(oDragon)< 21 &&
        GetLocalInt(oDragon, "nSurrendered") == 0)
    {
        SetLocalInt(oDragon, "nSurrendered", 1);
        SetImmortal(oDragon, FALSE);

        object oPC = GetFirstPC();

        AssignCommand(oPC, ClearAllActions(TRUE));
        ClearAllActions(TRUE);
        SurrenderToEnemies();
        ChangeToStandardFaction(oDragon, STANDARD_FACTION_MERCHANT);
        ActionDoCommand(ClearPersonalReputation(oPC,oDragon));
        ActionDoCommand(ClearPersonalReputation(oDragon,oPC));
        ActionDoCommand(ClearFollowersReputation(oPC,oDragon));
        ActionDoCommand(RemoveAllEffects(oDragon));
        ActionWait(2.5);
        ActionStartConversation(oPC);
    }
}
