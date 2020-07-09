//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_cfa37
//:: DATE: February 27, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether the Crippled Fang base has been
//:: found using its journal entry.
//:: The Henchman has to be hired.
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

int StartingConditional()
{
    object oPC = GetFirstPC();
    object oHench = OBJECT_SELF;
    int nJournal = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    return (HenchmanIsMine(oHench, oPC) &&
            (nJournal >= 37));
}
