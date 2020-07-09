#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        object oArea = GetArea(oPC);
        if (GetLocalInt(oArea, "nDrawbridgeOpen") == 0)
        {
            SetLocalInt(oArea, "nDrawbridgeOpen", 1);
            PlaySound("as_sw_lever1");
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            DelayCommand(1.0, CutscenePlay(oPC, "mv_ar2000_2"));//was 0.6
        }
        else
        {
            // the lever has already been used to open the doors
            FloatingTextStringOnCreature("... Nothing happens ...", oPC);
        }
    }
}
