//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_innovator
// DATE: March 30, 2006
// AUTH: Luke Scull/Rich Barker
// NOTE: Starts cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_cutscene"
void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);
        CutscenePlay(oPC, "cut_tm_innovator");
    }
}
