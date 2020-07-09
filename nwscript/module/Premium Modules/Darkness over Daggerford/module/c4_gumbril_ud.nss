#include "nw_i0_generic"
#include "hf_in_plot"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        int nPlotLevel = PlotLevelGet(GetTag(OBJECT_SELF));
        if (nPlotLevel == 2)
        {
            object oUmgatlik = GetNearestObjectByTag("ks_umgatlik");
            if (GetIsObjectValid(oUmgatlik) && !GetIsDead(oUmgatlik))
            {
                // act all woozy in umgatlik's prison
                SetLocalInt(OBJECT_SELF, "nConfused", 1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED), OBJECT_SELF, 6.0);
                ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 6.0);
            }
            else
            {
                // say something when you "snap out of it"
                if (GetLocalInt(OBJECT_SELF, "nConfused") == 1)
                {
                    SetLocalInt(OBJECT_SELF, "nConfused", 0);
                    ActionSpeakString("Huh? Where am I?");
                    ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);
                }
            }
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
