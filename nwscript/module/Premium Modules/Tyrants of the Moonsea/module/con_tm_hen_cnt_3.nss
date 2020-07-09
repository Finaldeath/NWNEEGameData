//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_hen_cnt_3
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Returns true if three Henchman are hired
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nHenchCount = HenchmanCount(oPC);

    return (nHenchCount == 3);
}

