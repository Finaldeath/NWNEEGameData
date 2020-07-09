void ForceAladaraDialog(object oPC)
{
    // Get aladara and player
    object oAladara = GetObjectByTag("DDF_NPC_Aladara");

    int iAladaraDone = GetLocalInt(oAladara, "alad_001_done");

    // If Aladara is done her dialog, she doesn't need to talk anymore
    if ( iAladaraDone )
        return;

    // If Aladara isn't in conversation, then start it
    if (IsInConversation(oAladara) == FALSE)
    {
        AssignCommand(oAladara, ActionStartConversation(oPC, "alad_001"));
    }

    // Recurse.
    DelayCommand(2.0, ForceAladaraDialog(oPC));
}

void main()
{
    object oEnter = GetEnteringObject();

    if (GetIsPC(oEnter))
    {
        ActionDoCommand(ForceAladaraDialog(oEnter));
    }
}


