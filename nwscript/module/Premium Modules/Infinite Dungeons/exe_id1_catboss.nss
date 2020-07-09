//:://////////////////////////////////////////////////////////////
//:: exe_id1_catarea                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    EDIT:
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////
#include "inc_id1_debug"

// int GetDoorType(object oDoor)
#include "inc_id1_gen"

// object GetNextCPU()
#include "inc_id1_utility"


const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    // get the current area being examined
    int nAreaNum = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    // create the name of the first area
    string sArea = "BossArea";
    object oMicroCPU;
    int nMicroNum;

    string sAreaName = sArea + IntToStringDigits(nAreaNum + nCount, 3);
    object oArea = GetObjectByTag(sAreaName);
    while ((oArea != OBJECT_INVALID) && (nCount < ID1_STEP_SIZE))
    {
//        DebugMessage("  Creating subprocess for area " + sAreaName);

        // create subprocess
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU55");
        SetLocalObject(oMicroCPU, "oArea", oArea);
        DelayCommand(0.01, ExecuteScript("exe_id1_catboss2", oMicroCPU));

        nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
        nMicroNum++;
        SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

        nCount++;
        sAreaName = sArea + IntToStringDigits(nAreaNum + nCount, 3);
        oArea = GetObjectByTag(sAreaName);
    }

    if (oArea == OBJECT_INVALID)
    {
//        DebugMessage("Area " + sAreaName + " does not exist.");

        nAreaNum = nAreaNum + nCount;

        // check the next set of areas for anything
        nCount = 0;
        while ((nCount < ID1_LOOK_AHEAD) && (oArea == OBJECT_INVALID))
        {
            nCount++;

            // get the next area to check
            sAreaName = sArea + IntToStringDigits(nAreaNum + nCount, 3);
            oArea = GetObjectByTag(sAreaName);
//            DebugMessage("  Checking area " + sAreaName);
        }

        if (oArea == OBJECT_INVALID)
        {
//            DebugMessage(" No more areas found.");

            // return to catalog generation
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        } else
        {
            // set new area to examine
            SetLocalInt(GetModule(), "nQueueMin", nAreaNum + nCount);

            // examine next area
            DelayCommand(0.01, ExecuteScript("exe_id1_catboss", GetNextCPU()));
        }
    } else
    {
//        DebugMessage("  Checking next set of areas.");

        // set new area to examine
        SetLocalInt(GetModule(), "nQueueMin", nAreaNum + nCount);

        // examine next area
        DelayCommand(0.01, ExecuteScript("exe_id1_catboss", GetNextCPU()));
    }
}

