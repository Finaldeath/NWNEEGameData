// sidequest: pirates of the moonsea
// .. ilandra has been persuaded to leave town

#include "hf_in_plot"

void main()
{
    PlotLevelSet("IlandraPirate", 1);

    // fade the screen to hide the disappearances
    object oPC = GetPCSpeaker();
    FadeToBlack(oPC, FADE_SPEED_FAST);
    AssignCommand(oPC, DelayCommand(2.0f, FadeFromBlack(oPC, FADE_SPEED_FAST)));

    float fDelay = 0.25f;

    // destroy ilandra
    object oIlandra = GetNearestObjectByTag("Ilandra", oPC);
    if (GetIsObjectValid(oIlandra))
    {
        DestroyObject(oIlandra, fDelay);
    }

    // destroy blizzard
    object oBlizzard = GetNearestObjectByTag("Blizzard", oPC);
    if (GetIsObjectValid(oBlizzard))
    {
        DestroyObject(oBlizzard, fDelay);
    }

    // destroy all of ilandra's crew
    int n = 1;
    object oCrew = GetNearestObjectByTag("IlandraCrew", oPC, n);
    while (GetIsObjectValid(oCrew))
    {
        DestroyObject(oCrew, fDelay);
        oCrew = GetNearestObjectByTag("IlandraCrew", oPC, ++n);
    }
}
