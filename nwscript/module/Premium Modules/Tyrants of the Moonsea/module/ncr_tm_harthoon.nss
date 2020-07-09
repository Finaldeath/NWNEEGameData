//Harthoon flees when reduced to 1 hit point

#include "hf_in_plot"

#include "inc_zkwar"

void main()
{
    if(GetCurrentHitPoints() == 1 && GetLocalInt(OBJECT_SELF, "iFlee") == 0)
    {
        object oPC = GetFirstPC();

        SetLocalInt(OBJECT_SELF, "iFlee", 1);
        SetPlotFlag(OBJECT_SELF, TRUE);
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_MERCHANT);
        ClearAllActions(TRUE);

        SurrenderToEnemies();
        ClearPersonalReputation(oPC, OBJECT_SELF);
        ClearPersonalReputation(OBJECT_SELF, oPC);
        ClearFollowersReputation(oPC, OBJECT_SELF);

        NotifyLieutentantDefeat();

        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES),
                            OBJECT_SELF);

        SpeakString("You will regret this, mortal!", TALKVOLUME_SHOUT);
        DelayCommand(3.0,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(OBJECT_SELF)));
        DestroyObject(OBJECT_SELF, 4.0);
    }
    else
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}
