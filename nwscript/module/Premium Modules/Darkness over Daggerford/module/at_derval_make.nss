// derval forges a weapon for the player

void main()
{
    object oPC = GetPCSpeaker();
    object oAnvil = GetObjectByTag("derval_sword");
    ActionPauseConversation();
    ActionMoveToObject(oAnvil);
    ActionDoCommand(SetFacingPoint(GetPosition(oAnvil)));
    ActionDoCommand(AssignCommand(oPC, PlaySound("as_cv_smithhamr1")));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 6.0);
    ActionWait(0.2);
    ActionDoCommand(AssignCommand(oPC, PlaySound("vs_nx2duerm_atk2")));
    ActionWait(0.2);
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE), OBJECT_SELF));
    ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
    ActionWait(0.3);
    ActionDoCommand(SetFacingPoint(GetPosition(oPC)));
    ActionResumeConversation();
}
