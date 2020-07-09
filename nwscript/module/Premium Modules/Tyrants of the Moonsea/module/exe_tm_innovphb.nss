//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_innovphb
// DATE: October 21, 2018
// AUTH: Rich Barker
// NOTE: PC follow script for Innovator in Dreadspire
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "nw_i0_plot"

void main()
{
    object oInnovator = OBJECT_SELF;
    object oPC = GetFirstPC();

    float fDelay = RoundsToSeconds(1);
    float fDistance = 0.0f;

    if(GetIsDead(oInnovator))
    {
        return;
    }

    if(!GetIsInCombat(oInnovator))
    {
        ClearAllActions(TRUE);
        fDistance = GetDistanceToObject(oPC);
        //If player is visible, attack
        if(CanSeePlayer())
        {
            DetermineCombatRound(oPC);
        }
        else
        {
            //if close but can't see PC, random walk and look around
            if(fDistance >= 0.0f && fDistance <= 2.0f  &&
               !CanSeePlayer())
            {
                ActionSpeakString("Where has that accursed irritation gone?");
                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
                ActionWait(2.0);
                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
                ActionRandomWalk();
                fDelay = 15.0;
            }
            //Otherwise keep following
            else
            {
                ActionForceFollowObject(oPC, 1.5);
            }
        }
    }

    //Call the script again after a suitable delay
    if(GetLocalInt(oInnovator, "iPursuing") == 1)
    {
        DelayCommand(fDelay, ExecuteScript("exe_tm_innovphb", oInnovator));
    }
    else
    {
        ClearAllActions(TRUE);
    }
}
