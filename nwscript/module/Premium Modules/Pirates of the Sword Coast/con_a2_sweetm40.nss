//::///////////////////////////////////////////////
//:: con_a2_sweetm40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has successfully persuaded Marie to
    join the PC's crew. And the PC is Male.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_SWEET");

    if((iPlot >= 40) && (GetGender(oPC) == GENDER_MALE))
    {
        return TRUE;
    }

    return FALSE;

}
