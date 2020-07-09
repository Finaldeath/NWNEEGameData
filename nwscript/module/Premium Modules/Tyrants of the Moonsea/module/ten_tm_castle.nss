//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_castle
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Fires Castle Maalthiir cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        // Fire cutscene script
        CutscenePlay(oPC, "cut_tm_castle");
        SetLocalInt(OBJECT_SELF, "fired", 1);
    }
}
