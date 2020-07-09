// griswald meets feldran by the gates at midnight

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    DelayCommand(1.5, CutscenePlay(oPC, "mv_ar2000_1"));
    // ... the delay here allows the camera to recover
    // ... otherwise it doesn't move right in the cutscene
}
