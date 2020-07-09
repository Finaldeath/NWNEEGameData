#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if ((nListType == 1) || (nListType == 2))
    {
        string sString = "";
        int bThemeSet = FALSE;

        // get theme type
        if (GetModuleFlag(ID1_FLAG_THEME_TYPE) == ID1_THEME_TYPE_THEMESET)
        {
            bThemeSet = TRUE;
            sString += "The dungeon will be based around a Theme Set.";
        } else
        {
            sString += "The dungeon will be based around a single Theme.";
        }
        sString = AddLineBreak(sString);

        // get theme selection
        if (GetModuleFlag(ID1_FLAG_THEME_SELECTION) == ID1_THEME_SELECTION_SPECIFIC)
        {
            // get specific theme selected
            int nSelected = GetModuleFlagValue(ID1_FLAG_THEME_SELECTION);

            // if invalid, set to THEME_ALL or THEME_SET_ALL
            if (nSelected < 1)
            {
                nSelected = 1;
                SetModuleFlagValue(ID1_FLAG_THEME_SELECTION, 1);
            }

            if (bThemeSet == TRUE)
            {
                // make sure theme set is within range
                int nThemeSetNum = GetLocalInt(GetModule(), "nThemeSet");
                if (nSelected > nThemeSetNum)
                {
                    nSelected = 1;
                    SetModuleFlagValue(ID1_FLAG_THEME_SELECTION, 1);
                }

                string sThemeSet = GetLocalString(GetModule(), "sThemeSet" + IntToString(nSelected) + "Name");

                sString += "Specific Theme Set selected is " + sThemeSet + ".";
            } else
            {
                // make sure theme is within range
                int nThemeNum = GetLocalInt(GetModule(), "nTheme");
                if (nSelected > nThemeNum)
                {
                    nSelected = 1;
                    SetModuleFlagValue(ID1_FLAG_THEME_SELECTION, 1);
                }

                string sTheme = GetLocalString(GetModule(), "sTheme" + IntToString(nSelected) + "Name");

                sString += "Specific Theme  selected is " + sTheme + ".";
            }
        } else
        {
            if (bThemeSet == TRUE)
            {
                sString += "Theme Set will be chosen randomly.";
            } else
            {
                sString += "Theme will be chosen randomly.";
            }
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
