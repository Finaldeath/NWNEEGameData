#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    if (nGold > 0)
    {
        TakeGoldFromCreature(nGold, oPC);
    }
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
}
