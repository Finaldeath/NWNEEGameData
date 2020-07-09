//Area OnEnter for Zhentil Keep Warzone - Temple Grounds

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC)&& GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        CutscenePlay(oPC, "cut_tm_zkgrounds");
    }
}
