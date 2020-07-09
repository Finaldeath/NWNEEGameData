//::////////////////////////////////////////////////////////////////////////////
//:: exe_puz_crstpzzl
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Script to spawn in the crystal puzzle involving the red, green and blue
    arrows and colored crystals. This script calls the CreatePuzzle function
    which creates the placeables the puzzle consists of.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_crstpzzl"

void main()
{
    object oPuzzleWP = OBJECT_SELF;
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");
    string sVar = sVarPrfx + B_PUZZLE_COMPLETED;

    int bCompleted = GetLocalInt(oDungeon, sVar);

    // DEBUG
    DebugMessage("");
    DebugMessage("exe_puz_crstpzzl");
    DebugMessage("Checking: " + sVar);
    DebugMessage("Result: " + IntToString(bCompleted));
    DebugMessage("");

    CreatePuzzle();

    // If the puzzle was completed previously spawn it in a completed state.
    if (bCompleted)
    {
        object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
        AssignCommand(oInvis, EndPuzzle(OBJECT_INVALID));
    }

    // SetLocalInt(oDungeon, sVarPrfx + N_PUZZLE_STATE, PUZ_ACTIVATED);
}
