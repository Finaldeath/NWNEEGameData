//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_cnt_1
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Returns true if only a single Henchman is hired
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nHenchCount = HenchmanCount(oPC);

    return (nHenchCount == 1);
}

