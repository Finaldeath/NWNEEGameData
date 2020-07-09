//::///////////////////////////////////////////////
//:: nsp_potsc_hench
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Custom spawn script for PotSC NPC Henchmen.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

#include "X0_INC_HENAI"
#include "inc_balance"

void main()
{
    SetAssociateListenPatterns();//Sets up the special henchmen listening patterns
    bkSetListeningPatterns();      // Goes through and sets up which shouts the NPC will listen to.

    SetAssociateState(NW_ASC_POWER_CASTING);

    if(GetLevelByClass(CLASS_TYPE_CLERIC) > 0)
    {
        SetAssociateState(NW_ASC_HEAL_AT_50);
    }
    else
    {
        SetAssociateState(NW_ASC_HEAL_AT_25);
    }

    if((GetLevelByClass(CLASS_TYPE_WIZARD) > 0)
      || (GetLevelByClass(CLASS_TYPE_SORCERER) > 0))
    {
        SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS, FALSE);
    }
    else
    {
        SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    }

    if ((GetLevelByClass(CLASS_TYPE_ROGUE) > 0)
      || (GetLevelByClass(CLASS_TYPE_RANGER) > 0))
    {
        SetAssociateState(NW_ASC_DISARM_TRAPS);
    }
    else
    {
        SetAssociateState(NW_ASC_DISARM_TRAPS, FALSE);
    }

    if((GetLevelByClass(CLASS_TYPE_PALADIN) > 0)
      || (GetLevelByClass(CLASS_TYPE_FIGHTER) > 0)
      || (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER) > 0))
    {
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    }
    else
    {
        SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    }

    if ((GetLevelByClass(CLASS_TYPE_ROGUE) > 0)
      || (GetLevelByClass(CLASS_TYPE_RANGER) > 0))
    {
        SetAssociateState(NW_ASC_USE_RANGED_WEAPON); //User ranged weapons by default if true.
    }
    else
    {
        SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE); //User ranged weapons by default if true.
    }

    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    SetIsDestroyable(FALSE, TRUE, FALSE);

    // LevelUpNPC(OBJECT_SELF);
    // Execute default OnSpawn script.
    // ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
