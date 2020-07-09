#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    int nCreature;
    string sCreature;
    int nThemeNum;


    int nLine;
    string sRead;
    int nRead;
    string s2DA = "creatures";
    int nMinCR;
    int nMaxCR;
    int bIntelligent;
    int bMediumSize;

    object oMicroCPU;


    // cycle through entries in the list
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        // get the resref of the current object
        sResRef = Get2DAString("creatures", "ResRef", nStart + nCount);

        if (sResRef != "")
        {
            DebugMessage("  Creature 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // add creature to list
            nCreature = GetLocalInt(GetModule(), "nCreature");
            nCreature++;
            SetLocalInt(GetModule(), "nCreature", nCreature);
//            SetLocalInt(GetModule(), "nCreature" + IntToString(nCreature) + "Line", nStart + nCount);

            nThemeNum = GetLocalInt(GetModule(), "nTheme1Creature");
            nThemeNum++;
            SetLocalInt(GetModule(), "nTheme1Creature", nThemeNum);
            SetLocalInt(GetModule(), "nTheme1Creature" + IntToString(nThemeNum), nCreature);

            sCreature = "Creature" + IntToString(nCreature);

            SetLocalInt(GetModule(), "nCreature_" + sResRef, nCreature);
            SetLocalString(GetModule(), "s" + sCreature + "ResRef", sResRef);

            // read in remaining creature details
            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU59");
            SetLocalInt(oMicroCPU, "nLine", nStart + nCount);
            SetLocalString(oMicroCPU, "sCreature", sCreature);
            SetLocalString(oMicroCPU, "s2DA", "creatures");
            SetLocalInt(oMicroCPU, "nCreature", nCreature);
            DelayCommand(0.01, ExecuteScript("exe_id1_miccre", oMicroCPU));
        }

        nCount++;
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("  Creature 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        int nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString("creatures", "OBJECT_RESREF", nStart + nCount);
            DebugMessage("  Creature 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("    Object found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catmon", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more creatures found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            SetLocalInt(GetModule(), "bTheme1CreatureGenerated", TRUE);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catmon", GetNextCPU()));
    }
}

