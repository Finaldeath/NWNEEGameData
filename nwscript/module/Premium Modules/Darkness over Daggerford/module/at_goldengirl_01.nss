// player buys a copy of matagar's golden book

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(1, oPC);
    CreateItemOnObject("ks_it_golden_bk", oPC, 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
}
