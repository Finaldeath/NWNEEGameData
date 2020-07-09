//::////////////////////////////////////////////////////////////////////////////
//:: pus_puz_tpcrstl
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Used script for the sonance crystals in the Trip's Prison puzzle.
    When used the crystals will breifly highlight the pedestal on which it rests
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 09, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

void main()
{
    object oThis, oPuzzleWP;
    object oPed;
    effect eVFX;
    string sTag;
    int nCrystal;

    oThis = OBJECT_SELF;
    nCrystal = GetLocalInt(oThis, S_CRYSTAL_NUM);
    eVFX = EffectVisualEffect(VFX_IMP_HASTE);

    DebugMessage("On Used: " + GetTag(oThis));

    sTag = S_PEDESTAL_TAG_PRFX + IntToString(nCrystal);

    oPed = GetObjectByTag(sTag);

    // Ensure validity.
    if (oPed == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag);
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPed);
    }

    // If the puzzle is in the second state (the imp has been summoned) the
    // crytsals should remain in an active state.
    oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);

    if (GetLocalInt(oPuzzleWP, S_SUMMONED_BOOL) == TRUE)
    {
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }

    ActionStartConversation(GetLastUsedBy());
}
