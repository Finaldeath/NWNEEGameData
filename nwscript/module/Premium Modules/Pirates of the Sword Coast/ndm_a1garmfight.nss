//::///////////////////////////////////////////////
//:: ndm_a1garmfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This NPC on damaged event scrip is for the NPC
    Garm in the fighting arena. If you bring Garm
    down to a single HP he will surrender and
    trigger his surrender cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    object oPC;

    int iDoOnce = GetLocalInt(oArea, "ndm_a1garmfight");
    int iHP = GetCurrentHitPoints();
    effect eHeal = EffectHeal(GetMaxHitPoints(oFighter));

    if ((iHP <= 1) && (iDoOnce == FALSE))
    {
        SetLocalInt(oArea, "ndm_a1garmfight", TRUE);
        SurrenderToEnemies();

        //end the fight cutscene for all the watchers
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC) == TRUE)
        {
            if (oPC != oFighter)
            {
                ExecuteScript("exe_a1nwtchfight", oPC);
            }

            UnpossessFamiliar(oPC);
            oPC = GetNextPC();
        }

        // Start the Garm Surrender movie for the fighter
        AssignCommand(oSelf, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHeal, oFighter);
        DelayCommand(0.5f, SetImmortal(oFighter, FALSE));
        DelayCommand(0.5f, ExecuteScript("cut_a1garmsurr", oFighter));
    }
    else
    {
        ExecuteScript ("nw_c2_default6", oSelf);
    }
}
