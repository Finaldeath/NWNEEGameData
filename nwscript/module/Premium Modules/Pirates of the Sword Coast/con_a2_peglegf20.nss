//::///////////////////////////////////////////////
//:: con_a2_peglegf20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Learned of Peg Legs weakness for
    wemon and liquer?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPlot = GetLocalInt(GetModule(), "A2_PEGLEG");
    int iGender = GetGender(oPC);


    if((iPlot >= 20) && (iGender == GENDER_FEMALE))
    {
        return TRUE;
    }

    return FALSE;

}
