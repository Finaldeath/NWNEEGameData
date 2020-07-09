#include "inc_id1_utility"

void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    // get primary themes
    int nPrimaryThemeNum = GetLocalInt(oImport, "nPrimaryTheme");
    int nPrimaryTheme = 1;
    string sTheme;
    while ((nPrimaryTheme <= nPrimaryThemeNum) && (bFail == FALSE))
    {
        // if theme is not present in the module
        sTheme = GetLocalString(oImport, "sPrimaryTheme" + IntToString(nPrimaryTheme) + "Name");
        DebugMessage("sPrimaryTheme" + IntToString(nPrimaryTheme) + "Name is " + sTheme);
        if (GetLocalInt(GetModule(), "nTheme_" + sTheme) == 0)
        {
            bFail = TRUE;
        } else
        {
            nPrimaryTheme++;
        }
    }

    // get secondary themes
    int nSecondaryThemeNum = GetLocalInt(oImport, "nSecondaryTheme");
    int nSecondaryTheme = 1;
    while ((nSecondaryTheme <= nSecondaryThemeNum) && (bFail == FALSE))
    {
        // if theme is not present in the module
        sTheme = GetLocalString(oImport, "sSecondaryTheme" + IntToString(nSecondaryTheme) + "Name");
        DebugMessage("sSecondaryTheme" + IntToString(nSecondaryTheme) + "Name is " + sTheme);
        if (GetLocalInt(GetModule(), "nTheme_" + sTheme) == 0)
        {
            bFail = TRUE;
        } else
        {
            nSecondaryTheme++;
        }
    }

    // get theme set
    string sThemeSetName = GetLocalString(oImport, "sThemeSetName");
    if (sThemeSetName != "")
    {
        if (GetLocalInt(GetModule(), "sThemeSet_" + sThemeSetName) == 0)
        {
            bFail = TRUE;
        }
    }

    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
