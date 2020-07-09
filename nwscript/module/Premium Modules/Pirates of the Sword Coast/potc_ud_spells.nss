//::///////////////////////////////////////////////
//:: User defined spell script
//:: potc_ud_spells
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script runs before any spell script.
    If the proper conditions are met, it can
    prevent the spell from firing, or just do
    things in response to spells in certain
    situations.

    So far, just does something if people start
    interfering with the Redtip fight.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10/05
//:://////////////////////////////////////////////
#include "inc_redtip"

void main()
{
    // OBJECT_SELF = whoever cast this spell

    // abort quickly if not a pc
    if(!GetIsPCNotDM(OBJECT_SELF)) return;

    // abort almost as quickly if we aren't in the area concerned
    // (the warehouse)
    object oArea = GetArea(OBJECT_SELF);
    if(GetTag(oArea) != "TownWarehouse") return;

    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip, oArea);
    // is there a player/Redtip fight on?
    if(GetLocalInt(oRedtip, l_n_REDTIP_BRAWL_ON))
    {
        object oPlayerInBrawl = GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_PLAYER_OBJECT);
        // make sure the caster isn't the player in the fight, or Redtip,
        // or the player's companion.
        // if it is, we allow them to cast
        if( (OBJECT_SELF != oPlayerInBrawl) &&
            (GetMaster(OBJECT_SELF) != oPlayerInBrawl) &&
            (OBJECT_SELF != oRedtip) )
        {
            // if the caster is targetting either the player or Redtip,
            // Redtip calls foul and the fight is over
            object oCastTarget = GetSpellTargetObject();
            if( (oCastTarget == oPlayerInBrawl) ||
                (GetMaster(oCastTarget) == oPlayerInBrawl) ||
                (oCastTarget == oRedtip))
            {
                // ok, some other player decided to be silly and interfere
                // in the fight. Redtip don't like cheaters.
                RedtipEndBrawl(l_nv_REDTIP_BRAWL_OUTCOME_CHEATED, oRedtip);
            }
        }
    }
}
