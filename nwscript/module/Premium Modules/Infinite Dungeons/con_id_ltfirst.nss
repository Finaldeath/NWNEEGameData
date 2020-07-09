//::///////////////////////////////////////////////
//:: con_id_ltfirst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has finished the first level of dungeon
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_FIRST_DUNGEON_COMPLETED) && (GetLocalInt(GetModule(), "bFirstLieutenant") == FALSE))
    {
//        SetLocalInt(GetModule(), "bFirstLieutenant", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
