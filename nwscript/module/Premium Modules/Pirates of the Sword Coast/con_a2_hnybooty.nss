//::///////////////////////////////////////////////
//:: con_a2_hnybooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does Honey Pea have Booty For sale?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oHoney = OBJECT_SELF;
    int iResult;

    if (GetLocalInt(oHoney, "TRE_BOOTY") == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
