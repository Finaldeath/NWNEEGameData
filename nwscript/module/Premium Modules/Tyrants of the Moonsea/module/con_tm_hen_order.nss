//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_order
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether:
//:: - the PC is currently in a Cormathor Forest area
//:: - Hilrad as given the PC the quest to hunt down the order
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

int CheckArea(object oPC)
{
    string sCurrentAreaTag = GetTag(GetArea(oPC));

    return( (sCurrentAreaTag == "CormOC") || (sCurrentAreaTag == "CormOC") );
}


int CheckJournal(object oPC)
{
    int nJournalEntry = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");
    return( (nJournalEntry == 36) || (nJournalEntry == 37) || (nJournalEntry == 38) );
}


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) && CheckArea(oPC) && CheckJournal(oPC));
}
