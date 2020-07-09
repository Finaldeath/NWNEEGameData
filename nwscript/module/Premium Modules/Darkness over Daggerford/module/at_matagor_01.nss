#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    CutsceneCameraSetup(-1.0, 40.0, 2.0, 85.0, CAMERA_TRANSITION_TYPE_FAST);
}
