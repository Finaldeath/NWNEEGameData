//::///////////////////////////////////////////////
//:: con_a2_kmrbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does Kolmarr have Booty For sale?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oKolmarr = OBJECT_SELF;
    int iResult;

    if (GetLocalInt(oKolmarr, "TRE_BOOTY") == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
