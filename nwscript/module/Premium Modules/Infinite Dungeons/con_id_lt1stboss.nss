//::///////////////////////////////////////////////
//:: con_id_lt1stboss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has defeated the first boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_FIRST_BOSS_DEFEATED) && (GetLocalInt(GetModule(), "bFirstBoss") == FALSE))
    {
//        SetLocalInt(GetModule(), "bFirstBoss", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
