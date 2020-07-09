//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_arenacell
// DATE: February 17, 2005
// AUTH: Luke Scull
// NOTE: Starts arena cell cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) &&(GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        // Fire cutscene script
        CutscenePlay(oPC, "cut_tm_arenacell");
        SetLocalInt(OBJECT_SELF, "fired", 1);
    }
}
