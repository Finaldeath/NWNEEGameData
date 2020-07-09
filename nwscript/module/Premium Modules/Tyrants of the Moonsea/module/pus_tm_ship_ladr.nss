// player uses the ladder in the ship hold to return up decks
// sidequest: muragh's magnificent machine (elder water elemental attack)

#include "hf_in_plot"
#include "hf_in_npc"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        // can't exit when hostiles are nearby
        object oHostile = GetNearestEnemy(oPC, 1);
        if (GetIsObjectValid(oHostile))
        {
            FloatingTextStringOnCreature("The ship is under attack!", oPC);
            return;
        }

        // can't exit without draining the water
        object oWater = GetNearestObjectByTag("tm_pl_grndwtb4x4", oPC);
        if (GetIsObjectValid(oWater))
        {
            FloatingTextStringOnCreature("The ship is sinking!", oPC);
            return;
        }

        // can't exit without the sapphire from the elder water elemental
        if (!GetIsItemPossessedByParty(oPC, "FlawlessSapphire"))
        {
            FloatingTextStringOnCreature("Water Elementals hold important gems. Look for one.", oPC);
            return;
        }

        // flag the quest done and return to the ship deck
        PlotLevelSet("ElderWaterElemental", 4);
        TeleportToWaypoint(oPC, "WP_RA_ELDER_DECK");
    }
}
