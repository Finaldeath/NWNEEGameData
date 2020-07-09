void main()
{
    int iIntroDone = GetLocalInt(OBJECT_SELF, "midtown_intro_done");
    //int iIntroDone = FALSE;

    // If we've never played the midtown intro
    if (iIntroDone == FALSE)
    {
        // Get the party leader
        object oLeader = GetFactionLeader(GetFirstPC());

        // Disable player control
        SetCutsceneMode(oLeader, TRUE);

        // Grab the guard
        object oGuard = GetObjectByTag("HarmoniumGuard0");

        // Play a text bubble
        AssignCommand(oGuard, SpeakString("You there, halt and be known!"));

        // Move towards the party leader
        DelayCommand(2.0, AssignCommand(oGuard, ActionMoveToObject(oLeader)));

        // Start a dialog
        DelayCommand(4.0, AssignCommand(oGuard, ActionStartConversation(oLeader, "hgua_001")));

        // Re-enable player control
        DelayCommand(4.0, SetCutsceneMode(oLeader, FALSE));

        // Set a flag so we only do this once
        SetLocalInt(OBJECT_SELF, "midtown_intro_done", TRUE);
    }
}
