#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void heartbeat()
{
    if (GetLocalInt(OBJECT_SELF, "HF_COMBAT_AGRESSIVE"))
    {
        if (!GetIsInCombat(OBJECT_SELF))
        {
            object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
            ActionAttack(oTarget);
        }
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        if (!GetHasFeat(FEAT_POINT_BLANK_SHOT) || GetLocalInt(OBJECT_SELF, "HF_COMBAT_RANGED"))
        {
            object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
            if (GetIsObjectValid(oWeapon))
            {
                if (GetWeaponRanged(oWeapon))
                {
                    // some creatures should avoid melee combat
                    SetCombatCondition(X0_COMBAT_FLAG_RANGED);
                }
            }
        }
        if (GetLocalInt(OBJECT_SELF, "HF_COMBAT_AGRESSIVE"))
        {
            SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        }
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        heartbeat();
    }
}

/*
  int X2_USERDEFINED_ONSPAWN_EVENTS
        You must set this variable to 3 on every NPC who uses this script.
  int HF_COMBAT_AGRESSIVE
        Set this to true if you want the NPC to seek out targets
  int HF_COMBAT_RANGED
        Set this to true if you want the NPC to use ranged weapons
*/
