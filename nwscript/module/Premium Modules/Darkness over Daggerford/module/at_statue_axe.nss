// the player places a stone axe in the statue's hands

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oAxe = GetItemPossessedBy(oPC, "bw_stoneaxe");
    if (GetIsObjectValid(oAxe))
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        PlotLevelSet(GetTag(OBJECT_SELF), 1);
        DestroyObject(oAxe);
        AssignCommand(oPC, PlaySound("it_materialhard"));
    }
}
