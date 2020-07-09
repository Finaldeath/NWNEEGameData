#include "hf_in_graphics"

void portalEnter(object o)
{
    location lLoc = GetLocation(o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_GREATER), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), o);
    DrawCircle(lLoc, 3.0, VFX_IMP_ELEMENTAL_PROTECTION);
    DrawLineVert(lLoc, VFX_IMP_ELEMENTAL_PROTECTION);
    DestroyObject(o, 1.0);
}

void main()
{
    // vfx
    object oSelf = OBJECT_SELF;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oSelf);
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oSelf));

    // gumbril gets pulled into the portal after a few rounds of combat
    if (GetLocalInt(OBJECT_SELF, "nActive") != 0)
    {
        object oGumbril = GetNearestObjectByTag("ks_gumbril");
        int nCounter = GetLocalInt(OBJECT_SELF, "nCounter");
        SetLocalInt(OBJECT_SELF, "nCounter", ++nCounter);
        if (nCounter >= 4)
        {
            if (GetIsObjectValid(oGumbril))
            {
                DelayCommand(1.0, portalEnter(oGumbril));
            }
            SetLocalInt(OBJECT_SELF, "nActive", 0);
            object oPC = GetFirstPC();
            AddJournalQuestEntry("j80", 4, oPC);
        }
        else if (nCounter == 1)
        {
            AssignCommand(oGumbril, SpeakOneLinerConversation());
        }
        else if (nCounter == 3)
        {
            PlayVoiceChat(VOICE_CHAT_PAIN1, oGumbril);
            AssignCommand(oGumbril, ActionSpeakString("HELP! Please! HELP!"));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_GRASPING_HAND), oGumbril, 12.0);
        }
    }
}
