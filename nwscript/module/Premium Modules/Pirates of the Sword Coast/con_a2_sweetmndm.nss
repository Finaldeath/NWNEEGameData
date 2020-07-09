//::///////////////////////////////////////////////
//:: con_a2_sweetmndm
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has started but not yet completed
    Sweet Maries Plot and is Male.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if((iPlot > 0) && (iPlot < 50)
      && (GetGender(oPC) == GENDER_MALE))
    {
        return TRUE;
    }

    return FALSE;

}
