//:://////////////////////////////////////////////////////////////
//:: exe_id1_maperase                                           //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script destroys the objects spawned in during the display
    of the map. This script destroys a single line of that map,
    then passes the script on to the next CPU in the series.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_gen"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    int nChildNum = GetLocalInt(OBJECT_SELF, "nChildNum");
    int nChild = 1;
    object oChild;
    while (nChild <= nChildNum)
    {
        oChild = GetLocalObject(OBJECT_SELF, "oChild" + IntToString(nChild));

        DestroyObject(oChild);

        nChild++;
    }
}
