//::///////////////////////////////////////////////
//:: con_id_lt3rdboss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has defeated the third boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_THIRD_BOSS_DEFEATED) && (GetLocalInt(GetModule(), "bThirdBoss") == FALSE))
    {
//        SetLocalInt(GetModule(), "bThirdBoss", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
