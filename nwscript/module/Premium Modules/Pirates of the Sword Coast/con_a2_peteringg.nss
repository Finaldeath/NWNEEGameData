//::///////////////////////////////////////////////
//:: con_a2_peteringg
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pete doesn't have his ring anymore
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPete = OBJECT_SELF;
    object oRing = GetItemPossessedBy(oPete, "a2_petering");
    int iResult = FALSE;

    if (GetIsObjectValid(oRing) == FALSE)
    {
        iResult = TRUE;
    }

    return iResult;
}
