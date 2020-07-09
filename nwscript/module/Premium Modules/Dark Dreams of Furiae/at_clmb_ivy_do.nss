void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetObjectByTag("DEST_CLIMB_IVY_01");

    // teleport them to the other location...
    FadeToBlack(oPC, FADE_SPEED_FAST);
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
    DelayCommand(1.5, FadeFromBlack(oPC, FADE_SPEED_FAST));
}
