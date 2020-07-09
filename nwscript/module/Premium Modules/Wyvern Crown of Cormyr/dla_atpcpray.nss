void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC,ActionPauseConversation());
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,5.0));
    AssignCommand(oPC,ActionResumeConversation());
}
