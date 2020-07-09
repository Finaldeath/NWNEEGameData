//::///////////////////////////////////////////////
//:: con_a2_peglegnd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has started but not completed the
    PegLeg Paulson drinking plot and the player
    is Female.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPCSpeaker = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");
    int iGender = GetGender(oPCSpeaker);

    if((iPlot < 40) && (iPlot > 0)
      && (iGender == GENDER_FEMALE))
    {
        return TRUE;
    }

    return FALSE;

}
