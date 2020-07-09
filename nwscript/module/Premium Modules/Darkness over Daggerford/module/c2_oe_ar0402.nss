// onEnter event for ar0402 (castle basement) plays a simple cutscene

#include "hf_in_cutscene"
#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nCutscenePlayed") == 0)
        {
            SetLocalInt(GetModule(), "pm_endgame_start", 1);
            SetLocalInt(OBJECT_SELF, "nCutscenePlayed", 1);
            CutscenePlay(oPC, "mv_ar0402_1");
        }
        SpawnEnter(oPC);
    }
}
