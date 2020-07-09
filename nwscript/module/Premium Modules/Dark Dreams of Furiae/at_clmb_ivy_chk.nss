#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();
    int nStrBonus = (GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE) - 10) / 2;
    int nRequiredRoll = 8 + nStrBonus;
    int nRoll = d20(1);

        debug("Roll: " + IntToString(nRoll) + " <= " + IntToString(nRequiredRoll));
    if(nRoll <= nRequiredRoll)
    {
    // success
        SetLocalInt(oPC, "CLIMBED_IVY_WALL", TRUE);
        // kick off teleport etc.
        debug("Success");
    }
    else
    {
    // failure
        SetLocalInt(oPC, "CLIMBED_IVY_WALL", FALSE);
        debug("Failure");

        int nDamage = d6(1);
        int nHP = GetCurrentHitPoints(oPC);

        // was trying to make it so you don't die from the fall...
        // but maybe that is ok?

        //if(nHP - nDamage < 1) nDamage = (nDamage - nHP) - 2;
        //if(nDamage < 0) nDamage = 0;

        effect eDmg = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
        DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC));
    }



}
