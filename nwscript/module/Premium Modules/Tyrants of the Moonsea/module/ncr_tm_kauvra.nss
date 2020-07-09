//Kauvra flees when reduced to 1 hit point

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
                            EffectVisualEffect(VFX_FNF_LOS_EVIL_30),
                            OBJECT_SELF);

        SpeakString("Curse you! But your sweet blood will soon be mine!", TALKVOLUME_SHOUT);
        //Leave in gaseous form
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), OBJECT_SELF);
        DelayCommand(0.4, SetCreatureAppearanceType(OBJECT_SELF, 818));
        DelayCommand(1.0,
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                EffectVisualEffect(VFX_DUR_SMOKE), OBJECT_SELF));
        DelayCommand(1.2, ActionMoveAwayFromObject(oPC, TRUE));
        DestroyObject(OBJECT_SELF, 7.0);
    }
    else
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}
