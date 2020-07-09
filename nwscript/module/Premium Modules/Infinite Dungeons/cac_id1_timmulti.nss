#include "inc_id1_flags"

void main()
{
    // detect if the game is multiplayer
    object oPC = GetPCSpeaker();
    string sKey = GetPCPublicCDKey(oPC);
    if (sKey == "")
    {
        SetLocalInt(GetModule(), "bMultiplayer", FALSE);
    } else
    {
        SetLocalInt(GetModule(), "bMultiplayer", TRUE);

        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, -1);
        SetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE, ID1_ENCOUNTER_SIZE_NORMAL);
        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, 50);
    }
}
