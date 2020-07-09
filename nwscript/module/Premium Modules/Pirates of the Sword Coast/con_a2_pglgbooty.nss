//::///////////////////////////////////////////////
//:: con_a2_pglgbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does Peg Leg have Booty For sale?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPegLeg = OBJECT_SELF;
    int iResult;

    if (GetLocalInt(oPegLeg, "TRE_BOOTY") == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
