//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_elf
// DATE: March 18, 2006
// AUTH: Luke Scull
// NOTE: Update journal quest entry for Elf and set int.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    // Only update this when the arena is in progress
    if (GetLocalInt(GetFirstPC(), "hillsfarpass") < 1)
    {
        AddJournalQuestEntry("HillsfarArenaElf", 20, GetFirstPC());
    }
    ExecuteScript("hf_friend_death", OBJECT_SELF);
}
