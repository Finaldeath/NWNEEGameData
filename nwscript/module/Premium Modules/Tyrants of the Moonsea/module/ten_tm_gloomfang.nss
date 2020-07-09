#include "hf_in_cutscene"

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_glomfang
// DATE: November 1, 2005
// AUTH: Luke Scull/Rich Barker
// NOTE: Starts Gloomfang cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        // Fire cutscene script
        SetLocalInt(OBJECT_SELF, "fired", 1);

        CutscenePlay(oPC, "cut_tm_gloomfang");
    }
}
