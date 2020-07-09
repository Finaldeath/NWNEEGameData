// January 2006
// B W-Husey
// PC & Latim wrestle.

void main()
{
    object oPC = GetPCSpeaker();
    object oLatim = OBJECT_SELF;
    object oEleanor = GetNearestObjectByTag("Eleanor");
    ActionPauseConversation();
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oLatim,ClearAllActions());
    AssignCommand(oLatim,ActionEquipMostDamagingMelee());
    AssignCommand(oPC,ActionMoveToObject(oLatim,FALSE,0.5));
    AssignCommand(oLatim,ActionMoveToObject(oPC,TRUE,0.5));
    AssignCommand(oLatim,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,4.0));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK,1.0));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0));
    AssignCommand(oLatim,ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK,1.0));
    AssignCommand(oLatim,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,4.0));
    DelayCommand(4.0,AssignCommand(oEleanor, ActionMoveToObject(oPC,TRUE,1.0)));
    ActionResumeConversation();
}
