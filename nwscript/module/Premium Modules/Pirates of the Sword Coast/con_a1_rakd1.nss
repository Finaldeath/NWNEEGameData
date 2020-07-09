//::///////////////////////////////////////////////
//:: con_a1_rakd1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do once for Draks trog shop.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "con_a1_rakd1");
    int iResult = FALSE;

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "con_a1_rakd1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
