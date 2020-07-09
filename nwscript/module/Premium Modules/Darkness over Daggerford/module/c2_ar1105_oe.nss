// onEnter event for AR1105
// .. just play a cutscene

#include "hf_in_cutscene"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nScenePlayed") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nScenePlayed", 1);
            CutscenePlay(oPC, "mv_ar1105_1");
        }
        else
        {
            // skully always follows the player around in the tower
            object oSkully = GetObjectInArea("ks_skully", OBJECT_SELF);
            if (!GetIsObjectValid(oSkully))
            {
                DestroyObject(oSkully);
                object oWP = GetWaypointByTag("WP_AR1105_SKULLY");
                oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
            }
        }
    }
}
