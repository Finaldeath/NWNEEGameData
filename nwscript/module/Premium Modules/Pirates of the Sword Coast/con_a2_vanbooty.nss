//::///////////////////////////////////////////////
//:: con_a2_vanbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does Vantabular have Booty For sale?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oVantab = OBJECT_SELF;
    int iResult;

    if (GetLocalInt(oVantab, "TRE_BOOTY") == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
