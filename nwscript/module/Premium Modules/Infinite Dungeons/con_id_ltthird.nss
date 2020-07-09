//::///////////////////////////////////////////////
//:: con_id_ltthird
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has finished the third level of dungeon
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_THIRD_DUNGEON_COMPLETED) && (GetLocalInt(GetModule(), "bThirdLieutenant") == FALSE))
    {
//        SetLocalInt(GetModule(), "bThirdLieutenant", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
