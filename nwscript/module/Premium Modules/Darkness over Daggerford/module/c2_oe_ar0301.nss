// onEnter event for AR0301 (Daggerford Barracks)
// .. just some cleanup

#include "hf_in_spawn"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // run the PJ spawns for this area
        SpawnEnter(oPC);

        // after the player learns that the griffs are zhents, make capt. drath unavail
        // .. the player will meet him again in illefarn
        if (GetLocalInt(GetModule(), "teygan_quests") >= 2)
        {
            object oDrath = GetObjectInArea("pm_capt_drath", OBJECT_SELF);
            if (GetIsObjectValid(oDrath))
            {
                DestroyObject(oDrath);
            }
        }

        // there shouldn't be any griffons around at the end game
        if (GetLocalInt(GetModule(), "pm_endgame_start") == 1)
        {
            object oGriffon = GetObjectInArea("pm_griffon1", oPC);
            if (GetIsObjectValid(oGriffon))
            {
                DestroyObject(oGriffon);
            }
        }
    }
}
