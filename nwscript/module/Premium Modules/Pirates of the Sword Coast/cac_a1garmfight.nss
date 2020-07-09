//::///////////////////////////////////////////////
//:: cac_a1garmfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate the Garm Fight intro cutscene for
    all players in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "inc_global"

void main()
{
    //todo script the Garm Fight
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetPCSpeaker();

    SetLocalObject(oArea, "A1_CURRFIGHTER", oPC);
    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_StartCutscene_Poly("cut_garmfight", "cut_a1watchfight", 1.0f, FALSE, FALSE, 10, oArea);

    /*
    oPC = GetFirstPC();
    while(GetIsObjectValid(oPC) == TRUE)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);
        oPC = GetNextPC();
    }
    */
}
