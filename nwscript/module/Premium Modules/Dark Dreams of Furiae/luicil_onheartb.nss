#include "ddf_util"

void main()
{
    string sWasHenching = "was_henching";

    int bWasHench = GetLocalInt(OBJECT_SELF, sWasHenching);
    object oPC = GetMaster();
    int bPCValid = GetIsObjectValid(oPC);

    if(bWasHench == TRUE && bPCValid == FALSE)
    {
        debug("-- luicil is no longer henching.");

        // no longer henching.
        // do all the things.
        SetLocalInt(OBJECT_SELF,sWasHenching, FALSE);
        // move back to original position.

        SpeakString("Well, this has been fun.");

        ClearAllActions(TRUE);
        object oTarget = GetObjectByTag("SpawnLuicil");
        //ActionJumpToObject(oTarget, TRUE);
        ActionForceMoveToObject(oTarget, TRUE, 1.0f, 3.0f);

        int iVal = GetMaxHitPoints() - GetCurrentHitPoints();
        if(iVal > 0)
        {
            effect eHeal = EffectHeal(iVal);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }

        SetPlotFlag(OBJECT_SELF, TRUE);

        return;
    }

    if(bPCValid == TRUE && bWasHench == FALSE)
    {
        debug("-- luicil is henching!");
        SetLocalInt(OBJECT_SELF, sWasHenching, TRUE);
    }

    ExecuteScript("nw_ch_ac1", OBJECT_SELF);

}
