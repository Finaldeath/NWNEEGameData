void main()
{
    // Early out if a player character didn't trigger this
    if (GetIsPC(GetEnteringObject()) == FALSE)
    {
        return;
    }

    int iIntroDone = GetLocalInt(OBJECT_SELF, "backdoor_intro_done");

    // If we've never played the midtown intro
    if (iIntroDone == FALSE)
    {
        // Get the guard in front of the back door
        object oGuard = GetObjectByTag("FraternityofOrderGuard6");

        // Play a text bubble
        AssignCommand(oGuard, SpeakString("You there! Stand and declare."));

        // Set a flag so we only do this once
        SetLocalInt(OBJECT_SELF, "backdoor_intro_done", TRUE);
    }

}
