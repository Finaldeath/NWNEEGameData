// the player takes the weapon, "Glory Fist," from a hole in Illefarn

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_weapon_17", oPC, 1);
    AssignCommand(oPC, PlaySound("it_metalbluntmed"));
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
