#include "hf_in_friend"

// returns true when combat is done for this character
int IsCombatDone(object oMaster)
{
    if (GetIsInCombat(oMaster))
    {
        return FALSE;
    }
    float fRange = GetLocalFloat(OBJECT_SELF, "HF_FRIEND_RANGE");
    if (fRange > 0.0)
    {
        object oEnemy = GetNearestEnemy();
        if (GetIsObjectValid(oEnemy))
        {
            float fDist = GetDistanceToObject(oEnemy);
            if (fDist < fRange)
            {
                return FALSE;
            }
        }
    }
    return TRUE;
}

void main()
{
    object oMaster = FriendGetMaster(OBJECT_SELF);
    if (GetIsObjectValid(oMaster))
    {
        // get up after combat ends
        if (FriendIsDead(OBJECT_SELF))
        {
            if (IsCombatDone(oMaster))
            {
                FriendRaise(OBJECT_SELF);
            }
        }

        // make sure that dead friends are lying down looking all dead like
        if (FriendIsDead(OBJECT_SELF))
        {
            if (GetCommandable())
            {
                ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 6500000000.0);
                SetCommandable(FALSE);
            }
        }

        // If dead or busy, return (without sending the user-defined event)
        if (FriendIsDead(OBJECT_SELF))
        {
            return;
        }
    }

    // run the standard npc heartbeat script
    ExecuteScript("x2_def_heartbeat", OBJECT_SELF);
}

