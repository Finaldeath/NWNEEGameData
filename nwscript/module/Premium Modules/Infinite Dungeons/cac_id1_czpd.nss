#include "inc_id1_flags"
#include "inc_id1_text"

void main()
{
    string sString = "";
    int nTemp;

    // puzzle difficulty
    if (GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY) == ID1_PUZZLE_DIFFICULTY_HARD)
    {
        sString += "Puzzle difficulty is set to Hard.";
    } else if (GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY) == ID1_PUZZLE_DIFFICULTY_NORMAL)
    {
        sString += "Puzzle difficulty is set to Normal.";
    } else
    {
        sString += "Puzzle difficulty is set to Easy.";
    }

    SetCustomToken(5100, sString);
}
