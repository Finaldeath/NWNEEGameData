#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) && !GetLocalInt(GetArea(oPC),"Falias_talked"))
    {
        SetLocalInt(GetArea(oPC),"Falias_talked",1);
        CutscenePlay(oPC, "mv_ar0601_1");
    }
}
