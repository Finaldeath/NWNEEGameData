//::///////////////////////////////////////////////
//:: aen_a3_sailaway
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handle the final cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_global"
#include "inc_balance"

void main()
{
    object oEntering = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iCounter, iDoOnce;

    int iPlot = GetLocalInt(GetModule(), "A3_WATER");
    int iMusic;

    cs_AreaOnEnter_Poly(oEntering);
    iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_sailaway");

    if ((iPlot == 100) && (GetIsPC(oEntering) == TRUE))
    {
        DayToNight(oEntering, 0.0f);
    }

    if ((iDoOnce == FALSE) && (GetIsPCNotDM(oEntering) == TRUE))
    {
        SetLocalInt(OBJECT_SELF, "aen_a3_sailaway", TRUE);
        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);

        if (iPlot == 100)
        {
            iMusic = MusicBackgroundGetNightTrack(oArea);
            MusicBackgroundChangeDay(oArea, iMusic);
        //    cs_StartCutscene_Poly("cut_a3_sailawayb", "", 2.0f, FALSE, TRUE, 10, oArea);
        }
        //else
        //{
        //    cs_StartCutscene_Poly("cut_a3_sailawaya", "", 2.0f, FALSE, TRUE, 10, oArea);
        //}
        cs_StartCutscene_Poly("cut_a3_sailaway", "", 2.0);
    }
}
