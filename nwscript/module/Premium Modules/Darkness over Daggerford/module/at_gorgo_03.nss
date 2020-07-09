#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    float fAngle = GetDirection(oNPC, oPC) + 60.0;
    float fRange = GetHorizontalDistanceBetween(oNPC, oPC) * 3.0;
    float fPitch = 90.0;
    if (fAngle > 360.0) fAngle -= 360.0;
    if (fRange < 2.0)   fRange = 2.0;

    AssignCommand(oPC, SetCameraFacing(fAngle, fRange, fPitch));
}
