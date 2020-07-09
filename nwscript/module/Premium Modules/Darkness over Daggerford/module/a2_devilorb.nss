// the orb of devil containment kills gorgomorz when < 50% hit points

#include "x2_inc_switches"

void Error(object oPC, string sText)
{
    FloatingTextStringOnCreature(sText, oPC);
}

void Activate(object oPC, object oItem, object oTarget)
{
    if (GetLocalInt(oItem, "nUsed"))
    {
        Error(oPC, "... Gorgomorz is already trapped inside the orb ...");
        return;
    }

    if (!GetIsObjectValid(oTarget))
    {
        Error(oPC, "... No target selected ...");
        return;
    }

    if (GetTag(oTarget) != "ks_gorgomorz")
    {
        Error(oPC, "... Target must be a Devil ...");
        return;
    }

    if (GetIsDead(oTarget))
    {
        Error(oPC, "... Gorgomorz is already dead ...");
        return;
    }

    if (GetCurrentHitPoints(oTarget) > GetMaxHitPoints(oTarget)/2)
    {
        Error(oPC, "... Gorgomorz is not below 50% hit points ...");
        return;
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(9999), oTarget);
    SetLocalInt(oItem, "nUsed", 1);
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        object oItem = GetItemActivated();
        object oTarget = GetItemActivatedTarget();
        Activate(oPC, oItem, oTarget);
    }
}
