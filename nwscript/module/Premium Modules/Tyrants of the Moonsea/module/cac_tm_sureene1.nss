//Sureene gives xp reward and 'Fiendfoe' for rescuing sisters

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    GiveXPToCreature(oPC, 500);
    CreateItemOnObject("x2_wblmhw006", oPC);
    PlotLevelSet(GetTag(OBJECT_SELF), 3);
}
