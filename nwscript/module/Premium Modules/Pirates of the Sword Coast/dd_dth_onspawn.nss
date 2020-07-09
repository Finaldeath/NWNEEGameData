//::///////////////////////////////////////////////
//:: Name dd_dth_onspawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script of Crewmen
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "inc_balance"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void main()
{
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
        SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    //Sets up the special henchmen listening patterns
    SetAssociateListenPatterns();
    // Goes through and sets up which shouts the NPC will listen to.
    bkSetListeningPatterns();

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
        //User ranged weapons by default if true.
        SetAssociateState(NW_ASC_USE_RANGED_WEAPON);
        SetCombatCondition(X0_COMBAT_FLAG_RANGED);
    }
    else
    {
        SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    }

    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    SetIsDestroyable(FALSE, TRUE, FALSE);

    LevelUpNPC(OBJECT_SELF);
    // Execute default OnSpawn script.
    // ExecuteScript("nw_c2_default9", OBJECT_SELF);
    //Post Spawn event requeste

    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
        SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }
}
