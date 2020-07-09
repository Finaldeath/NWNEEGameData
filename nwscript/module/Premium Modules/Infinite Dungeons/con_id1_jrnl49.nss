#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // floor trap
    nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_FLOOR_FREQUENCY);
    sString += "The chance of a floor trap being active is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // door trap
    nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DOOR_FREQUENCY);
    sString += "The chance of a door being trapped is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // chest trap
    nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_CHEST_FREQUENCY);
    sString += "The chance of a treasure chest being trapped is " + IntToString(nTemp) + "%.";
    sString = AddLineBreak(sString);

    // get detect difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_SELECTION) == ID1_TRAP_DETECT_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_SELECTION);
        sString += "Trap base detect difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base detect difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get detect difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER) == ID1_TRAP_DETECT_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER);
        sString += "Trap detect difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap detect difficulty is fixed.";
    }
    sString = AddLineBreak(sString);

    // get disarm difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_SELECTION) == ID1_TRAP_DIFFICULTY_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_SELECTION);
        sString += "Trap base disarm difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base disarm difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get disarm difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER) == ID1_TRAP_DIFFICULTY_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER);
        sString += "Trap disarm difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap disarm difficulty is fixed.";
    }
    sString = AddLineBreak(sString);

    // get damage difficulty selection
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION) == ID1_TRAP_DAMAGE_SELECTION_SET)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION);
        sString += "Trap base saving throw difficulty is set to " + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap base saving throw difficulty is based on player level.";
    }
    sString = AddLineBreak(sString);

    // get damage difficulty number
    if (GetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER) == ID1_TRAP_DAMAGE_NUMBER_RANDOM)
    {
        nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER);
        sString += "Trap saving throw difficulty varies within +/-" + IntToString(nTemp) + ".";
    } else
    {
        sString += "Trap saving throw difficulty is fixed.";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
