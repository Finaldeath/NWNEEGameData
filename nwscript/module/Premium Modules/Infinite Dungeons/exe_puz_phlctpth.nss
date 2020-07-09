//::////////////////////////////////////////////////////////////////////////////
//:: exe_puz_phlctpth
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    This script should be called to set up and activate the Phylactery Path
    puzzle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 29, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_phlctpth"
#include "inc_id1_utility"

void main()
{
    object oPuzzleWP = OBJECT_SELF;
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");
    string sVar = sVarPrfx + B_PUZZLE_COMPLETED;

    int bCompleted = GetLocalInt(oDungeon, sVar);

    // DEBUG
    DebugMessage("");
    DebugMessage("exe_puz_phlctpth");
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
