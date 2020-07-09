//:://////////////////////////////////////////////////
//:: c2_ox_am_worldmap
/*
  OnExit script for world map area.

  This script will restore creatures who leave the world
  map to their normal appearance and properties.

*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2005 Bioware Corp.
//:: Created By: Brian Watson for Ossian Studios
//:: Created On: 7/17/2006
//:://////////////////////////////////////////////////

#include "inc_bw_worldmap"

void stepBack(object oAssoc, object oMaster);

void main()
{
    object oExiter = GetExitingObject();

    MapRestore(oExiter);

    if (GetIsPC(oExiter))
    {
        SetLocalInt(OBJECT_SELF, "iHeartbeat", 0);

        int i = 1;

        object oHostile = oExiter;

        while(oHostile != OBJECT_INVALID)
        {
            oHostile = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                          REPUTATION_TYPE_ENEMY,
                                          GetObjectByTag("wmp_mapcenter"),
                                          i);
            if(GetIsObjectValid(oHostile) &&
               GetAssociateType(oHostile) == ASSOCIATE_TYPE_NONE)
            {
                DestroyObject(oHostile);
            }

            i++;
        }

        FadeFromBlack(oExiter);

        SetLocalInt(oExiter, "nWM_UsedInventoryMap", 0);  // reset
    }
    else
    {
        object oMaster = GetMaster(oExiter);

        if (GetIsObjectValid(oMaster))
        {
            AssignCommand(oExiter, ActionDoCommand(stepBack(oExiter, oMaster)));
        }
    }
}

void stepBack(object oAssoc, object oMaster)
{
    AssignCommand(oAssoc, ActionMoveAwayFromObject(oMaster, TRUE, 1.0f));
}
