// dragoth performs the ritual off camera
// sidequest: dragoth the bone mage

void main()
{
    object oPC = GetPCSpeaker();

    ActionPauseConversation();
    FadeToBlack(oPC, FADE_SPEED_MEDIUM);
    DelayCommand(3.0f, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
    DelayCommand(4.0, ActionResumeConversation());
}
