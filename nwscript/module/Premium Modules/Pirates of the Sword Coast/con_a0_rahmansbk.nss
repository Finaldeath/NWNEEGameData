//:://////////////////////////////////////////////
//:: con_a0_rahmansbk
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have Rahman's book in its inventory?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBook = GetItemPossessedBy(oPC, "a0_rahmansbook");

    if(GetIsObjectValid(oBook) == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
