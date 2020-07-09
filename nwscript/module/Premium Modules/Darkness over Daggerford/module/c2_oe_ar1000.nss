// onEnter event for AR1000 (Gillian's Hill)
// .. play at most one of the cutscenes here
// .. yentai's scene takes priority over the lizards

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // the cheese scene must play before the lizards
        if (GetLocalInt(oPC, "ac_cheese_quest") == 1)
        {
            if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
                CutscenePlay(oPC, "mv_ar1000_1");
                return;
                // must exit here because we can't do back-to-back cutscenes
            }
        }

        // the lizard rampage scene plays
        if (GetLocalInt(OBJECT_SELF, "nCut2Played") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nCut2Played", 1);
            CutscenePlay(oPC, "mv_ar1000_2");
            return;
        }
    }
}
