//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_temple
// DATE: September 3, 2005
// AUTH: Luke Scull
// NOTE: Trigger for "Temple of Bane" cutscene
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        // Fire cutscene script
        SetLocalInt(OBJECT_SELF, "fired", 1);
        CutscenePlay(oPC, "cut_tm_temple");
    }
}
