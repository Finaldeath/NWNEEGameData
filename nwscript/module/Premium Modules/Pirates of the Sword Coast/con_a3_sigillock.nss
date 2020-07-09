//::///////////////////////////////////////////////
//:: con_a3_sigillock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has attempted to talk to a NPC under
    the power of a Sigil.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iStationed = GetLocalInt(OBJECT_SELF, "STATIONED");
    int iResult = FALSE;

    if (iStationed == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
