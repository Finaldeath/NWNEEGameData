//::///////////////////////////////////////////////
//:: con_a2_lghthsn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC's party NOT entered the
    Magic Light House Act 2?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iFlag = GetLocalInt(GetModule(), "aen_a2_lghths");
    int iReturn = FALSE;

    if(iFlag == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;

}
