// branon has told the player to keep the figure of wonderous power

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet("Branon_Secret", 1);
    object oItem = GetItemPossessedBy(oPC, "animalfigure1");
    if (GetIsObjectValid(oItem))
        SetIdentified(oItem, TRUE);
}
