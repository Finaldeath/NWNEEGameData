#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // boss area selection
    nTemp = GetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION);
    if (nTemp == ID1_BOSS_AREA_SELECTION_RANDOM)
    {
        sString += "This dungeon will have a random final boss area.";
    } else if (nTemp == ID1_BOSS_AREA_SELECTION_THEMESET)
    {
        sString += "This dungeon will have a final boss area based on its theme or theme set.";
    } else if (nTemp == ID1_BOSS_AREA_SELECTION_FIXED_SPECIFIC)
    {
        sString += "The final boss area for this dungeon is ";
        int nArea = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
        int nAreaNum = GetLocalInt(GetModule(), "nBossAreas" + IntToString(nArea));
        object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaNum));
        string sAreaName = GetName(oArea);
        string sAreaTag = GetTag(oArea);
        sString += sAreaName + " (" + sAreaTag + ").";
    } else if (nTemp == ID1_BOSS_AREA_SELECTION_FIXED_THEMESET)
    {
        sString += "The final boss area for this dungeon is ";
        int nArea = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
        int nAreaNum = GetLocalInt(GetModule(), "nBossThemeSetAreas" + IntToString(nArea));
        object oArea = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreaNum));
        string sAreaName = GetName(oArea);
        string sAreaTag = GetTag(oArea);
        sString += sAreaName + " (" + sAreaTag + ").";
    } else
    {
        sString += "This dungeon will not have a final boss area.";
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
