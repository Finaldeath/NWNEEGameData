#include "inc_id1_utility"
#include "inc_id1_text"

int StartingConditional()
{
    string sString = "";

    // get dungeon name
    int nDungeon = GetLocalInt(OBJECT_SELF, "nDungeonNumber");
    string sName = "Dungeon-" + IntToString(nDungeon);
    location lLocation = GetLocation(GetObjectByTag("CPU"));
    object oDungeon = RetrieveCampaignObject("ID_DATABASE", sName, lLocation);

    string sDungeonName = GetLocalString(oDungeon, "sDungeonName");
    sString += sDungeonName;
    sString = AddLineBreak(sString);

    // get dungeon dimensions
    int nMaxX = GetLocalInt(oDungeon, "nMaxX");
    int nMaxY = GetLocalInt(oDungeon, "nMaxY");
    int nDungeonDepth = GetLocalInt(oDungeon, "nDungeonDepth");
    sString += "The dungeon is " + IntToString(nMaxX);
    if (nMaxX == 1)
    {
        sString += " area wide, " + IntToString(nMaxY);
    } else
    {
        sString += " areas wide, " + IntToString(nMaxY);
    }
    if (nMaxY == 1)
    {
        sString += " area long and " + IntToString(nDungeonDepth);
    } else
    {
        sString += " areas long and " + IntToString(nDungeonDepth);
    }
    if (nDungeonDepth == 1)
    {
        sString += " level deep.";
    } else
    {
        sString += " levels deep.";
    }
    sString = AddLineBreak(sString);

    // get dungeon primary themes
    int nPrimaryTheme = GetLocalInt(oDungeon, "nPrimaryTheme");
    if (nPrimaryTheme == 1)
    {
        sString += "The primary theme of this dungeon is ";
        sString += GetLocalString(oDungeon, "sPrimaryTheme1Name") + ".";
    } else
    {
        sString += "The primary themes of this dungeon are ";
        int nPrimary = 1;
        while (nPrimary < nPrimaryTheme)
        {
            sString += GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nPrimary) + "Name") + ", ";
            nPrimary++;
        }
        sString += GetLocalString(oDungeon, "sPrimaryTheme" + IntToString(nPrimary) + "Name") + ".";
    }
    sString = AddLineBreak(sString);

    // get dungeon primary themes
    int nSecondaryTheme = GetLocalInt(oDungeon, "nSecondaryTheme");
    if (nSecondaryTheme == 0)
    {
        sString += "This dungeon has no secondary themes.";
    } else if (nSecondaryTheme == 1)
    {
        sString += "The secondary theme of this dungeon is ";
        sString += GetLocalString(oDungeon, "sSecondaryTheme1Name") + ".";
    } else
    {
        sString += "The secondary themes of this dungeon are ";
        int nSecondary = 1;
        while (nSecondary < nSecondaryTheme)
        {
            sString += GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nSecondary) + "Name") + ", ";
            nSecondary++;
        }
        sString += GetLocalString(oDungeon, "sSecondaryTheme" + IntToString(nSecondary) + "Name") + ".";
    }
    sString = AddLineBreak(sString);

    sString += "Would you like to set this dungeon as the active one?";

    SetCustomToken(5200, sString);

    DestroyObject(oDungeon);

    return TRUE;
}
