//::////////////////////////////////////////////////////////////////////////////
//:: nd1_id1_boar
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Death Event script for the 'camoflage' boars; those boars that aren't
    actually lycanthropes. Creates anothe boar to replace the one killed after
    a random delay.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 27, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_antoine"

void main()
{
    int nRandomWP = Random(7) + 1;
    int nRandomDelay = Random(30);
    object oWP = DB_GetWaypointByTag(RETREAT_WAYPOINT + IntToString(nRandomWP));

    DelayCommand(IntToFloat(nRandomDelay), CreateBoar(oWP));

    // Default handling
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
