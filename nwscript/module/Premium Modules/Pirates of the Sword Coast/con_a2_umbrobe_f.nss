//::///////////////////////////////////////////////
//:: con_a2_umbrobe_f
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the player female and wearing an
    Umberlant Robe.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSahaugin = OBJECT_SELF;
    object oRobe = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int iResult = FALSE;

    if ((GetTag(oRobe) == "a2_umbrlntrobe")
      && (GetGender(oPC) == GENDER_FEMALE))
    {
        iResult = TRUE;
    }

    return iResult;
}
