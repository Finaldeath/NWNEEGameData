//::///////////////////////////////////////////////
//:: con_a2_sewermn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Are any of the sewers left un-enabled?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oFightClb = GetWaypointByTag("a2_sewers_fightclub");
    object oBlkBPrison = GetWaypointByTag("a2_sewers_prison");
    object oSpnDrftDocks = GetWaypointByTag("a2_sewers_docks");
    object oUmbTemple = GetWaypointByTag("a2_sewers_btemple");

    int iResult = FALSE;

    if ((GetLocalInt(oFightClb, "SEWER_ENABLED") == FALSE)
      || (GetLocalInt(oBlkBPrison, "SEWER_ENABLED") == FALSE)
      || (GetLocalInt(oSpnDrftDocks, "SEWER_ENABLED") == FALSE)
      || (GetLocalInt(oUmbTemple, "SEWER_ENABLED") == FALSE))
    {
        iResult = TRUE;
    }

    return iResult;
}
