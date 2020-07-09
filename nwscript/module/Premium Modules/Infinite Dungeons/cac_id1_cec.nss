#include "inc_id1_flags"
#include "inc_id1_text"
#include "inc_id1_utility"

void main()
{
    string sString = "";
    int nTemp;

    // encounter corpses
    nTemp = GetModuleFlag(ID1_FLAG_ENCOUNTER_CORPSE);
    if (nTemp == ID1_ENCOUNTER_CORPSE_FADE)
    {
        sString += "Creature corpses will fade once they have been looted.";
    } else
    {
        sString += "Creature corpses will remain even after they have been looted.";
    }


    SetCustomToken(5100, sString);
}
