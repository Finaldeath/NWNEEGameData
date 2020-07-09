//::////////////////////////////////////////////////////////////////////////////
//:: cac_puz_tptkgem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Action Taken script for the crystal conversation when a player elects to
    place a gem inside a crystal. Removes the gem from the players inventroy
    and 'places' the gem in the crystal thereby toggling the state of the
    associated pedestal.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

void main()
{
    object oPC, oGem, oThis;
    int nStackSize;

    oPC = GetPCSpeaker();
    oGem = GetItemPossessedBy(oPC, S_GEM_RESREF);
    oThis = OBJECT_SELF;

    if (oGem == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retreived from player inventory");
    }
    else
    {
        nStackSize = GetItemStackSize(oGem);

        PlaceGem(oThis, oGem);

        // If there is only one gem in the player's inventory destroy it.
        if (nStackSize == 1)
        {
            DestroyObject(oGem);
        }
        else // Otherwise reduce the stack size.
        {
            SetItemStackSize(oGem, (nStackSize - 1));
        }
    }
}
