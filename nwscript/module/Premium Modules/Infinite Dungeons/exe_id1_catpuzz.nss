#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // get starting point
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    // number of puzzles
    int nPuzzle;

    // difficulty settings
    int bEasy;
    int bNormal;
    int bHard;

    // go through entire 2da
    string sPuzzle = "default";
    while ((sPuzzle != "") && (nCount < ID1_STEP_SIZE))
    {
        // grab tileset resref
        sPuzzle = Get2DAString("puzzles", "PUZZLE_SCRIPT", nStart + nCount);

        if (sPuzzle != "")
        {
            DebugMessage("  Puzzle 2DA entry " + IntToString(nStart + nCount) + " is " + sPuzzle);

            // check if this is an easy puzzle
            bEasy = StringToInt(Get2DAString("puzzles", "EASY", nStart + nCount));
            if (bEasy == TRUE)
            {
                nPuzzle = GetLocalInt(GetModule(), "nPuzzleEasy");
                nPuzzle++;
                SetLocalInt(GetModule(), "nPuzzleEasy", nPuzzle);
                SetLocalString(GetModule(), "sPuzzleEasy" + IntToString(nPuzzle) + "Script", sPuzzle);
                DebugMessage("    sPuzzleEasy" + IntToString(nPuzzle) + " assigned script " + sPuzzle);
            }

            // check if this is an easy puzzle
            bNormal = StringToInt(Get2DAString("puzzles", "NORMAL", nStart + nCount));
            if (bNormal == TRUE)
            {
                nPuzzle = GetLocalInt(GetModule(), "nPuzzleNormal");
                nPuzzle++;
                SetLocalInt(GetModule(), "nPuzzleNormal", nPuzzle);
                SetLocalString(GetModule(), "sPuzzleNormal" + IntToString(nPuzzle) + "Script", sPuzzle);
                DebugMessage("    sPuzzleNormal" + IntToString(nPuzzle) + " assigned script " + sPuzzle);
            }

            // check if this is an easy puzzle
            bHard = StringToInt(Get2DAString("puzzles", "HARD", nStart + nCount));
            if (bHard == TRUE)
            {
                nPuzzle = GetLocalInt(GetModule(), "nPuzzleHard");
                nPuzzle++;
                SetLocalInt(GetModule(), "nPuzzleHard", nPuzzle);
                SetLocalString(GetModule(), "sPuzzleHard" + IntToString(nPuzzle) + "Script", sPuzzle);
                DebugMessage("    sPuzzleHard" + IntToString(nPuzzle) + " assigned script " + sPuzzle);
            }

            // record puzzle exists for import
            if ((bEasy == TRUE) || (bNormal == TRUE) || (bHard == TRUE))
            {
                SetLocalInt(GetModule(), "sPuzzle_" + sPuzzle, 1);
            }

            // increment counter
            nCount++;
        }
    }

    // if a null string was returned
    if (sPuzzle == "")
    {
        DebugMessage("  Puzzle 2DA entry " + IntToString(nStart + nCount) + " is " + sPuzzle);

        // reset starting point
        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        nCount = 0;
        while ((sPuzzle == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sPuzzle = Get2DAString("puzzles", "PUZZLE_SCRIPT", nStart + nCount);
            DebugMessage("  Puzzle 2DA entry " + IntToString(nStart + nCount) + " is " + sPuzzle);
        }

        // if another entry was found
        if (sPuzzle != "")
        {
            DebugMessage("  Puzzle found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catpuzz", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more puzzles found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("  Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catpuzz", GetNextCPU()));
    }
}

