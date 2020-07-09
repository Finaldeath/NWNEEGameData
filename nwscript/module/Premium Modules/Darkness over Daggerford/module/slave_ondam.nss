#include "nw_i0_generic"

void GoHostile(string sTag, object oPC)
{
    object oLizard = GetNearestObjectByTag(sTag, oPC);
    AdjustReputation(oPC, oLizard, -100);
    AssignCommand(oLizard, SetFacingPoint(GetPosition(oPC)));
    AssignCommand(oLizard, SpeakString("*hiss*"));
    AssignCommand(oLizard, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
    AssignCommand(oLizard, DetermineCombatRound(oPC));
}

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    object oEnemy = GetLastDamager();
    if(GetTag(oEnemy) != "ks_lizslave2")
    {
        GoHostile("lizwatcher1", oEnemy);
        GoHostile("lizwatcher2", oEnemy);
        GoHostile("lizslaver", oEnemy);
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
