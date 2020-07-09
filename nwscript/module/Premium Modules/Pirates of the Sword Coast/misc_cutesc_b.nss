//misc_cutesc_b
#include "inc_global"

void main()
{
    object oPC = GetLastUsedBy();
    object oArea = GetArea(oPC);

    SetLocalObject(oArea, "A1_ECSPC", oPC);
    cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, oArea);
    cs_StartCutscene_Poly("cut_a1_escapeb", "", 2.0f, TRUE, TRUE, 1, oArea);
}
