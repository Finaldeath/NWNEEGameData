void main()
{
    object oPC = GetPCSpeaker();
    ActionPauseConversation();
    FadeToBlack(oPC);
    DelayCommand(3.0, FadeFromBlack(oPC));
    DelayCommand(3.1, ActionResumeConversation());
}
