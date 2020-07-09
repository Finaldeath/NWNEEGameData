//::////////////////////////////////////////////////////////////////////////////
//:: pop_id1_attncrst
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    The on Opened script for any of the crystals in Hagatha's cave. When opened
    the crystal will create an 'Attuned Crystal' item that the player can use
    in the fight with Hagatha if there is not already one such item in the
    place-able's inventory.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_debug"

const string CRYSTAL_RESREF = "it_id1_attncrstl";

void main()
{
    // Starting with the place-able's first inventory item...
    object oThis = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oThis);

    // ... cycle through each item.
    while (GetIsObjectValid(oItem))
    {
        // If there is already a crystal present, jump out.
        if (GetTag(oItem) == CRYSTAL_RESREF)
        {
            return;
        }

        oItem = GetNextItemInInventory(oThis);
    }

    // If no crystal was found (the method control reaches this point) create
    // a new crystal item.
    object oCrstl = CreateItemOnObject(CRYSTAL_RESREF);

    if (!GetIsObjectValid(oCrstl))
    {
        DebugMessage("pop_id1_attncrstl::main() OBJECT_INVALID created.");
    }
}
