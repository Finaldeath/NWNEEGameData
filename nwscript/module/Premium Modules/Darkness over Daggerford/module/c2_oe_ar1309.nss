// player enters Hester's house; play cutscene with parrot

#include "hf_in_cutscene"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oParrot = GetObjectInArea("ks_druid_parrot", OBJECT_SELF);
        if (GetIsObjectValid(oParrot))
        {
            if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
                CutscenePlay(oPC, "mv_ar1309_1");
            }
        }
    }
}
