//::///////////////////////////////////////////////
//:: con_id_lt2ndboss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has defeated the second boss
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"

int StartingConditional()
{
    if ((lt_GetDungeonLevel() == ID_LOCAL_SECOND_BOSS_DEFEATED) && (GetLocalInt(GetModule(), "bSecondBoss") == FALSE))
    {
//        SetLocalInt(GetModule(), "bSecondBoss", TRUE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
