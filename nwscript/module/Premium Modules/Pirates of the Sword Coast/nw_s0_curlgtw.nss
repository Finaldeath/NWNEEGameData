//::///////////////////////////////////////////////
//:: Cure Light Wounds
//:: NW_S0_CurLgtW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When laying your hand upon a living creature,
// you channel positive energy that cures 1d8 points
// of damage plus 1 point per caster level (up to +5).
// Since undead are powered by negative energy, this
// spell inflicts damage on them instead of curing
// their wounds. An undead creature can attempt a
// Will save to take half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On: Oct 12, 2000
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 26, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

const string S_UNDEAD_CASTER = "On second thought, that's probably not a good idea.";

void main()
{
    //Undead players, henchmen, and crewmembers should not cast this on each other.
    object oTarget = GetSpellTargetObject();
    int bUndeadCaster = GetLocalInt(OBJECT_SELF, "IOP_CUST_UNDEAD");
    string sUndeadCasterPrefix = GetStringLeft(GetTag(OBJECT_SELF), 3);
    string sUndeadCasterSuffix = GetStringRight(GetTag(OBJECT_SELF), 5);
    int bUndeadTarget = GetLocalInt(oTarget, "IOP_CUST_UNDEAD");
    string sUndeadTargetPrefix = GetStringLeft(GetTag(oTarget), 3);
    string sUndeadTargetSuffix = GetStringRight(GetTag(oTarget), 5);
    if ((bUndeadCaster == TRUE ||
         (sUndeadCasterPrefix == "a3_" &&
          sUndeadCasterSuffix == "_dead")) &&
        (bUndeadTarget == TRUE ||
         (sUndeadTargetPrefix == "a3_" &&
          sUndeadTargetSuffix == "_dead")))
    {
        FloatingTextStringOnCreature(S_UNDEAD_CASTER, OBJECT_SELF, FALSE);
        return;
    }


/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook

    spellsCure(d8(), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_S, GetSpellId());
}

