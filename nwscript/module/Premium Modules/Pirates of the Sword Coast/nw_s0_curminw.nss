//::///////////////////////////////////////////////
//:: Cure Minor Wounds
//:: NW_S0_CurMinW
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// As cure light wounds, except cure minor wounds
// cures only 1 point of damage
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: Feb 22, 2001
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001

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

    spellsCure(4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, GetSpellId());
}