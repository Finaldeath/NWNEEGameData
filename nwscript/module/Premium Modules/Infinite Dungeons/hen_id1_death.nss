//::///////////////////////////////////////////////
//:: Henchman Death Script
//::
//:: NW_CH_AC7.nss
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: <description>
//:://////////////////////////////////////////////
//::
//:: Created By:
//:: Modified by:   Brent, April 3 2002
//::                Removed delay in respawning
//::                the henchman - caused bugs
//:: Modified November 14 2002
//::  - Henchem will now stay dead. Need to be raised
//:://////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Greater Restoration
//:: NW_S0_GrRestore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all negative effects of a temporary nature
    and all permanent effects of a supernatural nature
    from the character. Does not remove the effects
    relating to Mind-Affecting spells or movement alteration.
    Heals target for 5d8 + 1 point per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
#include "nw_i0_generic"
#include "nw_i0_plot"
#include "x0_i0_henchman"


void main()
{
    // * This is used by the advanced henchmen
    // * Let Brent know if it interferes with animal
    // * companions et cetera
    if (GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
    {
       object oHench = OBJECT_SELF;

        // * Take them out of stealth mode too (Nov 1 - BK)
        SetActionMode(oHench, ACTION_MODE_STEALTH, FALSE);

        // * Remove invisibility type effects off of henchmen (Nov 7 - BK)
        RemoveSpellEffects(SPELL_INVISIBILITY, oHench, oHench);
        RemoveSpellEffects(SPELL_IMPROVED_INVISIBILITY, oHench, oHench);
        RemoveSpellEffects(SPELL_SANCTUARY, oHench, oHench);
        RemoveSpellEffects(SPELL_ETHEREALNESS, oHench, oHench);
    }

    RemoveHenchman(GetMaster(), OBJECT_SELF);
}


