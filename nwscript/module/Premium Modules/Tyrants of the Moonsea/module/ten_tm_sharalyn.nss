//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_sharalyn
// DATE: September 14, 2005
// AUTH: Luke Scull
// NOTE: Spawns in Sharalyn and sets up dialogue cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0) && (GetLocalInt(oPC, "zacharusdead") == 1))
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);
        CutscenePlay(oPC, "cut_tm_sharalyn");
    }
}

