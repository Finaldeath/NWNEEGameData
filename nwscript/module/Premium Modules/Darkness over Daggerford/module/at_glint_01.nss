// the player takes zeal's walk (a magical suit of armor) from AR1100

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    CreateItemOnObject("ks_armour_12", oPC, 1);
    AssignCommand(oPC, PlaySound("it_armorchain"));
}
