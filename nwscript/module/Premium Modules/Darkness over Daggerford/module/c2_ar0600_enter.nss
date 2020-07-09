#include "hf_in_cutscene"

void main()
{
    object oEnter = GetEnteringObject();
    if (GetIsPC(oEnter))
    {
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            BlackScreen(oEnter);
            CutscenePlay(oEnter, "mv_ar0600_1");
        }
    }
}
