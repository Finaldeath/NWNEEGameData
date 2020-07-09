//::///////////////////////////////////////////////
//:: con_a2_grgbooty
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does Grog Beard have Booty For sale?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oGrogBeard = OBJECT_SELF;
    int iResult;

    if (GetLocalInt(oGrogBeard, "TRE_BOOTY") == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
