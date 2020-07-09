#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0) && (GetLocalInt(oPC, "elventreefinale") == 1))
    {
        // Fire cutscene script
        SetLocalInt(OBJECT_SELF, "fired", 1);
        CutscenePlay(oPC, "cut_tm_elventree");
    }
}
