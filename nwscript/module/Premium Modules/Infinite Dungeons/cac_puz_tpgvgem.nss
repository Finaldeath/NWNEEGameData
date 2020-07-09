//::////////////////////////////////////////////////////////////////////////////
//:: cac_puz_tpgvgem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Action Taken script for the crystal conversation when a player elects to
    remove a gem from inside a crystal. Deactivates the crystal and creats a gem
    in the player's inventory.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

void main()
{
    object oPC, oThis, oGem;

    oPC = GetPCSpeaker();
    oThis = OBJECT_SELF;

    oGem = CreateItemOnObject(S_GEM_RESREF, oPC);

    if (oGem == OBJECT_INVALID)
    {
        DebugMessage("INVALID object placement to player inventory");
    }
    else
    {
        PlaceGem(oThis, oGem);
    }
}
