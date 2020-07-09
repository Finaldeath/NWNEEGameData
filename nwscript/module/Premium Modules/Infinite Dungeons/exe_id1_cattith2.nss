#include "inc_id1_debug"

void main()
{
    int nCurrentTileset = GetLocalInt(OBJECT_SELF, "nTileset");

    string sThemes = GetLocalString(GetModule(), "sTileset" + IntToString(nCurrentTileset) + "Themes");
    DebugMessage("Themes string for tileset " + IntToString(nCurrentTileset) + " is " + sThemes);

    string sSubString;
    int bRelationship;

    int nThemeNum = GetLocalInt(GetModule(), "nTheme");
    int nTheme = 1;
    while (nTheme <= nThemeNum)
    {
        // reading in the row of this tileset and record
        sSubString = GetSubString(sThemes, nTheme - 1, 1);
        bRelationship = StringToInt(sSubString);
        SetLocalInt(GetModule(), "bTileset" + IntToString(nCurrentTileset) + "Theme" + IntToString(nTheme), bRelationship);
        SetLocalInt(GetModule(), "bTheme" + IntToString(nTheme) + "Tileset" + IntToString(nCurrentTileset), bRelationship);
        DebugMessage("  Relationship between tileset " + IntToString(nCurrentTileset) + " and theme " + IntToString(nTheme) + " is " + IntToString(bRelationship));

        nTheme++;
    }

    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);

    DestroyObject(OBJECT_SELF);
}
