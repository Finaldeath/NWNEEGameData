//::///////////////////////////////////////////////
//:: ndt_potsc_hench
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Custom Death script for PotSC NPC Henchmen.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

// Edited Aug 25, 2005, Jason
// Included some henchman options for ID.
#include "inc_safehench"

void main()
{
/*    int nFlag = GetLocalInt(GetModule(),ID1_FLAG_DEATH_HENCHMEN_DEATH);
    switch (nFlag)
    {
        case ID1_DEATH_HENCHMEN_DEATH_RESPAWN_DELAY:
        case ID1_DEATH_HENCHMEN_DEATH_RESPAWN_PLAYER:
        case ID1_DEATH_HENCHMEN_DEATH_RESPAWN_COMBAT_END:
        {
            // Henchman hangs around dead.
            HandleDeath();
            break;
        }
    }*/
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

