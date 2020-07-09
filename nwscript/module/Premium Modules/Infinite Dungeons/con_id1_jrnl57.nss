#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // encounter size
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE);
    if (nTemp == ID1_ENCOUNTER_SIZE_SINGLE)
    {
        sString += "Encounter size is single creatures only.";
    } else if (nTemp == ID1_ENCOUNTER_SIZE_LARGE)
    {
        sString += "Encounter size is large (approximately 2-3 times party size).";
    } else if (nTemp == ID1_ENCOUNTER_SIZE_HORDE)
    {
        sString += "Encounter size is very large (approximately 4-6 times party size).";
    } else
    {
        sString += "Encounter size is normal (approximately equal to party size).";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
