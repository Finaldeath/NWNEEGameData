// the player has found the shoreside shipping records

void main()
{
    object oPC = GetPCSpeaker();
    object oMod = GetModule();

    if (GetLocalInt(oMod, "barge_activity") < 2)
    {
        AddJournalQuestEntry ("barge_activity", 2, oPC, TRUE);
        SetLocalInt(oMod, "barge_activity", 2);
    }
}
