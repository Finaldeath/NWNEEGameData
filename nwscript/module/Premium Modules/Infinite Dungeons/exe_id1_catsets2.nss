#include "inc_id1_debug"
#include "inc_id1_gen"

void main()
{
    int nLine = GetLocalInt(OBJECT_SELF, "nLine");

    string s2DA = "themesets";

    // get set name
    string sThemeSet = Get2DAString(s2DA, "SET_NAME", nLine);

    // add set
    int nThemeSet = GetLocalInt(GetModule(), "nThemeSet");
    nThemeSet++;
    SetLocalInt(GetModule(), "nThemeSet", nThemeSet);
    SetLocalString(GetModule(), "sThemeSet" + IntToString(nThemeSet) + "Name", sThemeSet);
    SetLocalInt(GetModule(), "nThemeSet_" + sThemeSet, nThemeSet);
    DebugMessage("Setting themeset " + sThemeSet + " as " + IntToString(nThemeSet));

    object oThemeSet = GetObjectByTag("BossArea_" + sThemeSet);
    if (oThemeSet != OBJECT_INVALID)
    {
        DebugMessage("  Themeset has a boss area.");

        // set number of actual areas found
        int nAreas = GetLocalInt(GetModule(), "nQueueMax");
        nAreas++;
        SetLocalInt(GetModule(), "nQueueMax", nAreas);

        SetLocalInt(oThemeSet, "nAreaIdentifier", nAreas);
        SetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nAreas), oThemeSet);

        int nBossThemeSetAreas = GetLocalInt(GetModule(), "nBossThemeSetAreas");
        nBossThemeSetAreas++;
        SetLocalInt(GetModule(), "nBossThemeSetAreas", nBossThemeSetAreas);
        SetLocalInt(GetModule(), "nBossThemeSetAreas" + IntToString(nBossThemeSetAreas), nAreas);
        SetLocalInt(GetModule(), "nBossThemeSetArea_" + sThemeSet, nBossThemeSetAreas);

        DebugMessage("  Setting BossArea_" + sThemeSet + " to be " + IntToString(GetLocalInt(oThemeSet, "nAreaIdentifier")));

        int nDoor = 0;
        object oObject = GetFirstObjectInArea(oThemeSet);

        string sTag;
        int nDoorType;

        // cycle through objects in the area
        while (oObject != OBJECT_INVALID)
        {
            // get the tag of the current
            sTag = GetTag(oObject);


            //////////////////////////////////////////////////////////////////
            // Doors                                                        //
            //////////////////////////////////////////////////////////////////

            if (sTag == "ID1_STATIC_DOOR")
            {
                // get the current number of doors
                nDoor = GetLocalInt(oThemeSet, "nDoor");

                // add the new door to the door configuration
                nDoorType = GetDoorType(oObject);
                nDoor += nDoorType;

                // set the new door configuration
                SetLocalInt(oThemeSet, "nDoor", nDoor);

                // add a link to the door object
                if (nDoorType == ID1_DOOR_NORTH)
                {
                    DebugMessage("  Setting North door.");
                    SetLocalObject(oThemeSet, "oDoorNorth", oObject);
                } else if (nDoorType == ID1_DOOR_EAST)
                {
                    DebugMessage("  Setting East door.");
                    SetLocalObject(oThemeSet, "oDoorEast", oObject);
                } else if (nDoorType == ID1_DOOR_SOUTH)
                {
                    DebugMessage("  Setting South door.");
                    SetLocalObject(oThemeSet, "oDoorSouth", oObject);
                } else if (nDoorType == ID1_DOOR_WEST)
                {
                    DebugMessage("  Setting West door.");
                    SetLocalObject(oThemeSet, "oDoorWest", oObject);
                }
            }

            oObject = GetNextObjectInArea(oThemeSet);
        }
    }

    string sThemeName;
    int nRelationship;
    int nTemp;

    // read in themes information
    string sThemes = "0" + Get2DAString("themesets", "THEMES", nLine);
    DebugMessage("sThemes is " + sThemes);

    int nThemeNum = GetLocalInt(GetModule(), "nTheme");
    int nTheme = 1;
    string sSubTheme;
    while (nTheme <= nThemeNum)
    {
        // reading in the row of this tileset and record
        sSubTheme = GetSubString(sThemes, nTheme - 1, 1);
        DebugMessage("  sSubTheme for theme " + IntToString(nTheme) + " is " + sSubTheme);

        nRelationship = StringToInt(sSubTheme);

        // if this is a primary theme in the set
        if (nRelationship == 1)
        {
            nTemp = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Primary");
            nTemp++;
            SetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Primary", nTemp);
            SetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Primary" + IntToString(nTemp), nTheme);
            DebugMessage("    Setting nThemeSet" + IntToString(nThemeSet) + "Primary" + IntToString(nTemp) + " to " + IntToString(nTheme));
        }

        // if this is a secondary theme in the set
        if (nRelationship == 2)
        {
            nTemp = GetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Secondary");
            nTemp++;
            SetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Secondary", nTemp);
            SetLocalInt(GetModule(), "nThemeSet" + IntToString(nThemeSet) + "Secondary" + IntToString(nTemp), nTheme);
            DebugMessage("    Setting nThemeSet" + IntToString(nThemeSet) + "Secondary" + IntToString(nTemp) + " to " + IntToString(nTheme));
        }

        nTheme++;
    }

    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");
    nMicroDead++;
    SetLocalInt(GetModule(), "nMicroDead", nMicroDead);

    DestroyObject(OBJECT_SELF);
}
