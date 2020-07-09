#include "NW_I0_GENERIC"
#include "nw_i0_plot"

void main()
{
    object oJunior = OBJECT_SELF;
    object oPC = GetFirstPC();

    int iCount;
    int iGender;

    float fDelay = RoundsToSeconds(1);
    float fDistance = 0.0f;

    string sGender;
    string sPronoun;

    if((GetLocalInt(oJunior, "iHowled") == 0) && !CanSeePlayer() && !GetIsInCombat(oJunior))
    {
        iCount = GetLocalInt(oJunior, "iCount");
        iCount++;
        SetLocalInt(oJunior, "iCount", iCount);
        if(iCount > 1)
        {
            SetLocalInt(oJunior, "iHowled", 1);
            SoundObjectPlay(GetObjectByTag("ac_snd_werewolf2"));
        }
    }

    if(!GetIsInCombat(oJunior))
    {
        ClearAllActions(TRUE);
        fDistance = GetDistanceToObject(oPC);
        //If we're getting close, give the player a warning
        if((GetLocalInt(oJunior, "iScented") == 0) &&
           fDistance >= 5.0f && fDistance <= 20.0f &&
           !CanSeePlayer())
        {
            SetLocalInt(oJunior, "iScented", 1);
            ActionSpeakString("The scent is strong! My present must be nearby!", TALKVOLUME_SHOUT);
            ActionWait(5.0);
            fDelay = 7.0;
        }
        //If player is visible, attack
        if(CanSeePlayer())
        {
            SoundObjectStop(GetObjectByTag("ac_snd_werewolf"));
            SoundObjectStop(GetObjectByTag("ac_snd_werewolf2"));
            DetermineCombatRound(oPC);
        }
        else
        {
            //if close but can't see PC, random walk and look around
            if(fDistance >= 0.0f && fDistance <= 2.0f  &&
               !CanSeePlayer())
            {
                iGender = GetGender(oPC);
                if(iGender == 0)
                {
                    sGender = "he";
                    sPronoun = "him";
                }
                else
                {
                    sGender = "she";
                    sPronoun = "her";
                }
                ActionSpeakString("Grrr! I can smell " + sPronoun + ", but where did " + sGender + " go?");
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
    if(GetLocalInt(oJunior, "iJuniorPursuing") == 1)
    {
        DelayCommand(fDelay, ExecuteScript("rb_junior_phb", oJunior));
    }
    else
    {
        ClearAllActions(TRUE);
    }
}
