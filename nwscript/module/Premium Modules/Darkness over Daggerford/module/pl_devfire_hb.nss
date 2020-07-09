// generator heartbeat script: pump out mephits if less than 4

#include "hf_in_plot"

void main()
{
    // do nothing if another thread is busy making mephits
    if (GetLocalInt(OBJECT_SELF, "nSemaphore") == 1)
        return;

    if (PlotLevelGet(GetTag(OBJECT_SELF)) == 0)
    {
        // lock the object to ensure that no one else is creating mephits
        SetLocalInt(OBJECT_SELF, "nSemaphore", 1);

        // count the number of mephits in the room
        int nCount = 0;
        int i = 1;
        object oMephit = GetNearestObjectByTag("ks_mephit_fire", OBJECT_SELF, i);
        while (GetIsObjectValid(oMephit))
        {
            if (!GetIsDead(oMephit))
                nCount++;
            oMephit = GetNearestObjectByTag("ks_mephit_fire", OBJECT_SELF, ++i);
        }

        if (nCount < 4)
        {
            // spawn a mephit
            object oPC = GetFirstPC();
            object oWP = GetWaypointByTag("WP_AR1106_FIRE_MEPHIT_SPAWN");
            location lLoc = GetLocation(oWP);
            object oMephit = CreateObject(OBJECT_TYPE_CREATURE, "ks_mephit_fire", lLoc);
            ClearPersonalReputation(oPC, oMephit);
            int nRepAdjust = 50 - GetReputation(oMephit, oPC);
            AdjustReputation(oPC, oMephit, nRepAdjust);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), lLoc);
        }
        else
        {
            // let out a puff of steam
            effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }

        // release the lock
        SetLocalInt(OBJECT_SELF, "nSemaphore", 0);
    }
}
