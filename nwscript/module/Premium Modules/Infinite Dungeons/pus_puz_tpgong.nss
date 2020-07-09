//::////////////////////////////////////////////////////////////////////////////
//:: pus_puz_tpgong
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Used script for the gong placeable in the 'Trip's Prison' puzzle.
    When used the gong will either summon an imp, if all the proper braziers are
    lit or highlight the braziers that should be lit.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 10, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

// Name: Summon Imp
//
// Defined in: puz_puz_tpgong
//
// Creates the impish gem carrier that is part of the 'Trip's Prison' puzzle at
// the center of the puzzle. Once created and validated the imp is supplied with
// all hte gems necessay to solve the puzzle.
//
// Parameters:
// NONE
//
// Return:
// NONE
void SummonImp();

void main()
{
    object oBrazier, oPuzzleWP, oCrystal, oUser;
    int i, bBraziers, bPedestals;
    string sTag;
    effect eVFX;
    location lLoc;

    // Ambient
    PlaySound("as_cv_gongring3");

    if (GetLocalInt(OBJECT_SELF, S_COMPLETE_BOOL)) return;

    // Check the puzzle state.
    bBraziers = CheckBrazierState();
    bPedestals = CheckPedestalState();

    oPuzzleWP = GetObjectByTag(CREATE_WP_TAG);
    oUser = GetLastUsedBy();

    // If all the target Braziers are active summon the imp or end the puzzle
    // depending on the state.
    if (bBraziers)
    {
        oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);

        if (oPuzzleWP == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retreived: " + CREATE_WP_TAG);
        }

        // If the gong is being rang and everything is in place finish up the puzzle.
        if (bPedestals)
        {
            SetLocalInt(OBJECT_SELF, S_COMPLETE_BOOL, TRUE);
            object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
            AssignCommand(oInvis, EndPuzzle(oUser));

            return;
        }
        /*else
        {
            // Re-randomize the crystal puzzle.
            DeactivatePedestals();
            RandomizeCrystalPuzzle();
        }*/

        // If the imp has already been summoned don't resummon.
        if (GetLocalInt(oPuzzleWP, S_SUMMONED_BOOL) == TRUE)
        {
            return;
        }

        eVFX = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        lLoc = GetLocation(oPuzzleWP);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);

        DelayCommand(1.0, SummonImp());
        DelayCommand(1.0, SetLocalInt(oPuzzleWP, S_SUMMONED_BOOL, TRUE));

        eVFX = EffectVisualEffect(VFX_IMP_DOMINATE_S);

        // All the crystals should now become active to indicate the puzzle state
        for (i = 0; i < N_CIRCLE_PEDESTALS; ++i)
        {
            sTag = S_CRYSTAL_TAG_PRFX + IntToString(i);
            oCrystal = GetObjectByTag(sTag);

            if (oCrystal == OBJECT_INVALID)
            {
                DebugMessage("INVALID object retreived: " + sTag);
            }

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oCrystal);
            AssignCommand(oCrystal, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SummonImp
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 11, 2005
//::////////////////////////////////////////////////////////////////////////////
void SummonImp()
{
    object oStore, oImp, oGem;
    location lLoc;

    // Get the store which contains all of the gems.
    oStore = GetObjectByTag(S_INVIS_OBJ_RESREF);

    // Ensure the object's validity.
    if (oStore == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retreived: " + S_INVIS_OBJ_RESREF);
        return;
    }

    // Create the Imp in the center of the puzzle.
    lLoc = GetLocation(oStore);
    oImp = CreateObject(OBJECT_TYPE_CREATURE, S_IMP_RESREF, lLoc);

    if (oImp == OBJECT_INVALID)
    {
        DebugMessage(S_IMP_RESREF + " INVALID at creation.");
        return;
    }

    oGem = GetFirstItemInInventory(oStore);

    // Cycle through all the items in the store's inventory coying them onto the imp.
    while (oGem != OBJECT_INVALID)
    {
        CopyItem(oGem, oImp);

        // Destroy the gems as they are copied to avoid multiples later.
        DestroyObject(oGem);

        oGem = GetNextItemInInventory(oStore);
    }
}
