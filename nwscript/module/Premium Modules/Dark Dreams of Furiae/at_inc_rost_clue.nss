#include "ddf_journal"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "gave_rooster_clue") == TRUE)
    {
        debug("-- can't give a clue twice...");
        return;
    }

    // Increase our clue count
    int iClueCount = GetLocalInt(GetModule(), "ddf_rooster_clue_count");
    iClueCount += 1;
    SetLocalInt(GetModule(), "ddf_rooster_clue_count", iClueCount);

    // Set a flag on ourselves so we don't give the clue again
    SetLocalInt(OBJECT_SELF, "gave_rooster_clue", TRUE);

    // Update Journal
    // TODO - Jos
    UpdateJournal(GetFirstPC());
}
