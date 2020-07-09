// the player removes the net covering the seagull/tatham thing

void main()
{
    object oPC = GetPCSpeaker();
    object oNet = GetNearestObjectByTag("psc_PLC_Net", oPC);
    ActionPauseConversation();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    DelayCommand(2.5, ActionResumeConversation());
    DestroyObject(oNet, 2.0);
}
