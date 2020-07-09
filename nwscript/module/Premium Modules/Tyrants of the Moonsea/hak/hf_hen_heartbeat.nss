#include "hf_in_henchman"
#include "hf_in_rest"

void main()
{
    // get up after combat ends
    if (HenchmanIsDead(OBJECT_SELF))
    {
        object oPC = GetMaster(OBJECT_SELF);
        if (!GetIsInCombat(oPC))
        {
            HenchmanRaise(OBJECT_SELF, oPC);
        }
    }

    // make sure that dead henchman are lying down looking all dead like
    if (HenchmanIsDead(OBJECT_SELF))
    {
        if (GetCommandable())
        {
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 6500000000.0);
            SetCommandable(FALSE);
        }
    }

    // If dead or busy, return (without sending the user-defined event)
    if(GetAssociateState(NW_ASC_IS_BUSY) || HenchmanIsDead(OBJECT_SELF))
        return;

    // Check to see if should re-enter stealth mode
    if (GetIsInCombat() == FALSE)
    {
        int nStealth=GetLocalInt(OBJECT_SELF, "X2_HENCH_STEALTH_MODE");
        if((nStealth == 1 || nStealth == 2) && GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == FALSE)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
        }
    }

    // if a ranged weapon was being used before battle, equip it back
    if (GetIsInCombat() == FALSE)
    {
        object oRight = GetLocalObject(OBJECT_SELF, "X0_L_RIGHTHAND");
        if (GetIsObjectValid(oRight) == TRUE)
        {
            SetLocalObject(OBJECT_SELF, "X0_L_RIGHTHAND", OBJECT_INVALID);
            if (GetWeaponRanged(oRight) == TRUE)
            {
                ClearAllActions();
                bkEquipRanged(OBJECT_INVALID, TRUE, TRUE);
                return;
            }
        }
    }

    // is this henchman tired?
    // .. the standard heartbeat script will clear my action queue
    // .. if I should be following my master
    if (GetIsInCombat() == FALSE && IsInConversation(OBJECT_SELF) == FALSE)
    {
        if (GetMaster(OBJECT_SELF) != OBJECT_INVALID)
        {
            if (HenchmanIsTired(OBJECT_SELF))
            {
                HenchmanSetTired(OBJECT_SELF);
                if (!RestAnimationsDisabled(OBJECT_SELF))
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 6.0);
                    if (d10() == 1)
                        SpeakString("*yawn*");
                }
            }
        }
    }

    // run the standard henchman heartbeat script
    ExecuteScript("nw_ch_ac1", OBJECT_SELF);
}

