//::///////////////////////////////////////////////
//:: con_a1_nocatgut
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC out of catgut?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCatgut = GetItemPossessedBy(oPC, "a1_catgut");

    int iResult = FALSE;

    if (GetIsObjectValid(oCatgut) != TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
