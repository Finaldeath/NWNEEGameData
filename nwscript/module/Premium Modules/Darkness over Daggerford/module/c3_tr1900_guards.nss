// player enters the lizardfolk village and is confronted by a guard

#include "inc_polymorph"
#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            if (IsPolymorphed(oPC))
            {
                object oGuard = GetNearestObjectByTag("lizguard1", oPC);
                if (GetObjectSeen(oPC, oGuard))
                {
                    CutscenePlay(oPC, "mv_ar1900_1");
                }
            }
        }
    }
}
