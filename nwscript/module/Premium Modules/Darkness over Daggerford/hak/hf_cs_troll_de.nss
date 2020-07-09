// death script for a troll
// .. trolls can only be killed by fire/acid damage

#include "NW_I0_GENERIC"

// was this creature damaged by acid or fire?
int IsFireAcidDamaged(object oSelf)
{
    int nFireDmg = GetLocalInt(oSelf, "nFireDmg");
    int nAcidDmg = GetLocalInt(oSelf, "nAcidDmg");
    int nA = GetDamageDealtByType(DAMAGE_TYPE_ACID);
    int nF = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    if (nFireDmg > 0 || nAcidDmg > 0 || nF > 0 || nA > 0)
    {
        return(TRUE);
    }
    return(FALSE);
}

// resurrect this creature with 25% hit points
void Resurrect(object oSelf)
{
    int nHits = GetMaxHitPoints(oSelf)/4;
    SetPlotFlag(oSelf, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oSelf);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHits), oSelf);
    AssignCommand(oSelf, SetIsDestroyable(TRUE, TRUE, TRUE));
    AssignCommand(oSelf, ClearAllActions(TRUE));
    AssignCommand(oSelf, DetermineCombatRound());
}

// resurrect after awhile if no fire or acid damage
// .. also put a cap on the maximum number of times we can come back to life
// .. otherwise we'd have an XP exploit and some frustrated players
void main()
{
    object oSelf = OBJECT_SELF;
    int nCount = GetLocalInt(oSelf, "nResurrectedCount");
    if (!IsFireAcidDamaged(oSelf) && nCount < 5)
    {
        SetLocalInt(oSelf, "nResurrectedCount", ++nCount);
        SetPlotFlag(oSelf, TRUE);
        AssignCommand(oSelf, SetIsDestroyable(FALSE, TRUE, TRUE));
        AssignCommand(oSelf, ClearAllActions(TRUE));
        DelayCommand(12.0, Resurrect(oSelf));
    }
}
