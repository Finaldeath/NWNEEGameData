//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndm_tm_artemis
// DATE: November 20, 2005
// AUTH: Luke Scull
// NOTE: When Entreri is reduced to 1 hp he will flee.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    int nMaxHP = GetMaxHitPoints();
    int nCurrHP = GetCurrentHitPoints();

    if ( ((nCurrHP * 120) <= nMaxHP) &&
         (GetLocalInt(OBJECT_SELF, "Generic_Surrender") == 0) &&
         (GetLocalInt(OBJECT_SELF, "NW_L_DOTHISONCE") == 0) )
    {
        SetLocalInt(OBJECT_SELF,"NW_L_DOTHISONCE",1);

        // Prevent this encounter from triggering again
        PlotLevelSet("ArtemisEntreriEncountered", 1);

        SurrenderToEnemies();
        SpeakString("Enough of this! We shall meet again.");
        GiveXPToCreature(GetFirstPC(), 500);

        SetLocalInt(OBJECT_SELF, "nBusy", 1);
        SetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED", 1);
        SetLocalInt(OBJECT_SELF,"Generic_Surrender",1);
        SetLocalInt(GetFirstPC(), "artemisdefeated", 1);

        DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION), OBJECT_SELF));
        DestroyObject(OBJECT_SELF, 4.0);
    }
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
