#include "ddf_util"

void main()
{
    int iHP = GetCurrentHitPoints();
    if(iHP == 1)
    {
        SetLocalInt(GetModule(), "ddf_luicil_died", TRUE);

        debug("-- Luicil @ 1HP - going home...");
        SpeakString("\"Well, this has been fun.\" *Luicil twists a ring on his finger and disappears*");
        object oPC = GetMaster();
        RemoveHenchperson(OBJECT_SELF);
        ClearAllActions(TRUE);
        object oTarget = GetObjectByTag("SpawnLuicil");
        //ActionJumpToObject(oTarget, FALSE);
        ActionForceMoveToObject(oTarget, FALSE, 1.0f, 0.5f);

        effect eHeal = EffectHeal(GetMaxHitPoints());
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);

        SetPlotFlag(OBJECT_SELF, TRUE);
    }
    else
    {
        ExecuteScript("nw_ch_ac6", OBJECT_SELF);
    }
}
