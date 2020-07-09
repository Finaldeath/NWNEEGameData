// sidequest: pirates of the moonsea
// .. veris has been persuaded to hand-over his ring instead of his head
// .. he also gives the player his fancy sword

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("item026", oPC);
    PlotLevelSet("Veris", 2);
    AddJournalQuestEntry("PiratesoftheMoonsea", 50, oPC, TRUE, FALSE, TRUE);

    object oSword =  GetItemPossessedBy(OBJECT_SELF, "NW_WSWMSC005");
    if (GetIsObjectValid(oSword))
    {
        ActionGiveItem(oSword, oPC);
    }
}
