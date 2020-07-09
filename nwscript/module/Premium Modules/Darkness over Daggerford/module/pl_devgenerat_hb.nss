// generator heartbeat script: pump out mephits if less than 4

#include "hf_in_plot"

void main()
{
    // do nothing if no player in the area
    if (GetArea(GetFirstPC()) != GetArea(OBJECT_SELF))
        return;

    // do nothing if another thread is busy making mephits
    if (GetLocalInt(OBJECT_SELF, "nSemaphore") == 1)
        return;

    // has the puzzle been solved?
    int nSolutionState = GetLocalInt(OBJECT_SELF, "nSolutionState");
    if (nSolutionState == 1)
    {
        // spawn the ice crystal
        object oIceSpawnPoint = GetWaypointByTag("WP_AR1106_ICE_CRYSTAL");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_icecrystal", GetLocation(oIceSpawnPoint));
        SetLocalInt(OBJECT_SELF, "nSolutionState", 2);
    }
    if (nSolutionState == 2)
    {
        // spawn the water
        object oIceSpawnPoint = GetWaypointByTag("WP_AR1106_ICE_CRYSTAL");
        location lLoc = GetLocation(oIceSpawnPoint);
        vector v = GetPositionFromLocation(lLoc);
        v.z = -0.5;
        location lLoc2 = Location(GetArea(OBJECT_SELF), v, 0.0);
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_water", lLoc2);
        SetLocalInt(OBJECT_SELF, "nSolutionState", 3);
    }
    if (nSolutionState == 3)
    {
        // spawn the water mephit
        object oWP = GetWaypointByTag("WP_AR1106_WATER_MEPHIT_SPAWN");
        object oMephit = CreateObject(OBJECT_TYPE_CREATURE, "ks_mephit_water", GetLocation(oWP));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_BLUR), oMephit);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oWP));
        SetLocalInt(OBJECT_SELF, "nSolutionState", 4);

        // skully comments
        object oSkully = GetNearestObjectByTag("ks_skully", OBJECT_SELF);
        string sQuote = GetLocalString(GetModule(), "QUOTE");
        AssignCommand(oSkully, ClearAllActions());
        AssignCommand(oSkully, ActionSpeakString(sQuote+"I tell you boss, between all this raging fire, ice, and water, it’s a wonder Edalseye has any books left in this library at all!"+sQuote));
    }

    int nPlot = PlotLevelGet(GetTag(OBJECT_SELF));
    if ( nPlot == 0)
    {
        // the generator is not plugged

        // lock the object to ensure that no one else is creating mephits
        SetLocalInt(OBJECT_SELF, "nSemaphore", 1);

        // count the number of mephits in the room
        int nCount = 0;
        int i = 1;
        object oMephit = GetNearestObjectByTag("ks_mephit_ice", OBJECT_SELF, i);
        while (GetIsObjectValid(oMephit))
        {
            if (!GetIsDead(oMephit))
                nCount++;
            oMephit = GetNearestObjectByTag("ks_mephit_ice", OBJECT_SELF, ++i);
        }

        if (nCount < 4)
        {
            // spawn a mephit
            object oPC = GetFirstPC();
            object oWP = GetWaypointByTag("WP_AR1106_ICE_MEPHIT_SPAWN");
            location lLoc = GetLocation(oWP);
            object oMephit = CreateObject(OBJECT_TYPE_CREATURE, "ks_mephit_ice", lLoc);
            ClearPersonalReputation(oPC, oMephit);
            int nRepAdjust = 50 - GetReputation(oMephit, oPC);
            AdjustReputation(oPC, oMephit, nRepAdjust);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FROST_L), lLoc);
        }
        else
        {
            // there are enough mephits, just let out a puff of steam
            effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        }

        // release the lock
        SetLocalInt(OBJECT_SELF, "nSemaphore", 0);

        // check if we should spawn the water to end the puzzle
        object oFlame = GetNearestObjectByTag("ks_pl_devflame", OBJECT_SELF);
        if (GetIsObjectValid(oFlame))
        {
            // the fire generator is around
            if (GetLocalInt(OBJECT_SELF, "nSolutionState") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nSolutionState", 1);
            }
        }
    }
    else if (nPlot == 1)
    {
        // the generator is plugged with dirt
        // .. fire mephits start spawning when
        // .. 1 - all ice mephits are dead
        // .. 2 - all burning pillars are turned on
        object oMephit = GetNearestObjectByTag("ks_mephit_ice", OBJECT_SELF);
        if (!GetIsObjectValid(oMephit))
        {
            // no more ice mephits
            object oFire = GetNearestObjectByTag("_ar1106_fire", OBJECT_SELF);
            if (GetIsObjectValid(oFire))
            {
                // all four pillars are on
                object oFlame = GetNearestObjectByTag("ks_pl_devflame", OBJECT_SELF);
                if (!GetIsObjectValid(oFlame))
                {
                    // the flame is only created once and never destroyed
                    // .. otherwise this won't work

                    // ice crystal melts
                    object oIce = GetNearestObjectByTag("ks_pl_icecrystal", OBJECT_SELF);
                    location lLoc = GetLocation(oIce);
                    DestroyObject(oIce);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_FIRE), lLoc);

                    // all snow in the area melts
                    int i = 1;
                    object oSnow = GetNearestObjectByTag("x0_snowdrift", OBJECT_SELF, i);
                    while (GetIsObjectValid(oSnow))
                    {
                        DestroyObject(oSnow);
                        oSnow = GetNearestObjectByTag("x0_snowdrift", OBJECT_SELF, ++i);
                    }

                    // spawn the fire "generator"
                    object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devflame", lLoc);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD), oFlame);

                    // activate the burning trigger
                    object oTrigger = GetNearestObjectByTag("ks_tr_fire", OBJECT_SELF);
                    SetLocalInt(oTrigger, "nActive", 1);

                    // comments about how hot it is getting
                    object oPC = GetFirstPC();
                    AssignCommand(oPC, ActionSpeakString("It is getting hot in here!"));
                    object oSkully = GetNearestObjectByTag("ks_skully", OBJECT_SELF);
                    DelayCommand(10.0, AssignCommand(oSkully, ActionSpeakString(GetLocalString(oSkully, "HF_QUOTE")+"Uh...boss? Don’t you think it’s getting a bit hot in here? I mean, I’m used to flaming skulls and all, but you’re starting to look a little...um...glistening."+GetLocalString(oSkully, "HF_QUOTE"))));
                }
            }
        }
    }
    else
    {
        // the generator has been switched off (puzzles are done)
    }
}
