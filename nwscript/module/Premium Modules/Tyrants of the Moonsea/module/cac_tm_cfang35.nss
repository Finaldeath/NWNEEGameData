// maalthir tells the player about elventree

// Moved into cut_tm_castle
// TODO: Delete

#include "hf_in_worldmap"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("OrderoftheCrippledFang", 35, oPC);
    UnlockMapLocation("Elventree");
}
