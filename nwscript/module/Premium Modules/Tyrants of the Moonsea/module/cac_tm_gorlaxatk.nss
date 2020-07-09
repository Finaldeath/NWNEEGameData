// gorlax and his umber hulk friends attack the player

#include "NW_I0_GENERIC"

// remove cutscene freeze effects from a character
void Unfreeze(object oPC)
{
    effect eEff = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEff))
    {
        int nType = GetEffectType(eEff);
        if (nType == EFFECT_TYPE_CUTSCENEIMMOBILIZE || nType == EFFECT_TYPE_CUTSCENE_PARALYZE)
        {
            RemoveEffect(oPC, eEff);
        }
        eEff = GetNextEffect(oPC);
    }
}

// make an NPC hostile towards the player
void GoHostile(object oNPC)
{
    SetPlotFlag(oNPC, FALSE);
    SetImmortal(oNPC, FALSE);
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, DetermineCombatRound());
}

void main()
{
    object oPC = GetPCSpeaker();
    Unfreeze(oPC);

    int n = 1;
    object oUmber = GetNearestObjectByTag("GorlaxUmberHulk", OBJECT_SELF, n);
    while (GetIsObjectValid(oUmber))
    {
        GoHostile(oUmber);
        oUmber = GetNearestObjectByTag("GorlaxUmberHulk", OBJECT_SELF, ++n);
    }

    GoHostile(OBJECT_SELF);
}
