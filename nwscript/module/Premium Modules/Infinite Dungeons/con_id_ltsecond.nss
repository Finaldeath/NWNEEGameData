//::///////////////////////////////////////////////
//:: con_id_ltsecond
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has finished the second level of dungeon
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_SECOND_DUNGEON_COMPLETED) && (GetLocalInt(GetModule(), "bSecondLieutenant") == FALSE))
    {
//        SetLocalInt(GetModule(), "bSecondLieutenant", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
