// opening the door in AR0507 triggers a cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
        CutscenePlay(oPC, "mv_ar0507_1");
    }
}
