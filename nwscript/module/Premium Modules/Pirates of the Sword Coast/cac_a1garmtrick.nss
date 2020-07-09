#include "_inc_generic"

// Knock Down Garm
void RemoveEffects (object oPC);

void main()
{
    object oArea = GetObjectByTag("a1_trogarena");
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    object oGarm = GetObjectByTag("a1_garmclone");
    object oClone = GetObjectByTag("A1PC_CLONE");
    object oPC;

    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);

    AssignCommand(oGarm, ActionMoveToObject(oClone, FALSE, 1.0f));
    oPC = GetFirstObjectInArea(oArea);

    ActionPauseConversation();

    // Remove effects from the PC and let them Get Up
    DelayCommand(2.0f, RemoveEffects(oClone));
    DelayCommand(3.0f, AssignCommand(oClone, ClearAllActions(TRUE)));
    DelayCommand(3.5f, AssignCommand(oClone, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
    DelayCommand(3.5f, AssignCommand(oClone, PlayVoiceChat(VOICE_CHAT_CHEER, oClone)));

    DelayCommand(2.0f, AssignCommand(oGarm,
        PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0f, 5.0f)));

    DelayCommand(4.0f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oGarm));

    while (GetIsObjectValid(oPC) == TRUE)
    {
        if ((oPC == oFighter) || ((GetLocalInt(oPC, "A1_WATCHING_FIGHT") == TRUE)
          && (GetIsPCNotDM(oPC) == TRUE)))
        {
            FadeToBlack(oPC);
            DelayCommand(3.5f, FadeFromBlack(oPC));
        }

        oPC = GetNextObjectInArea(oArea);
    }

    //DelayCommand(2.5f, ClearAllActions(TRUE));
    DelayCommand(4.0f, ActionResumeConversation());
}

void RemoveEffects (object oPC)
{
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.5f, RemoveEffect(oPC, eEffect));
        }
        eEffect = GetNextEffect(oPC);
    }
}
