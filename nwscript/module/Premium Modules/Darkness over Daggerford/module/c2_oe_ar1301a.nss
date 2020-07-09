// play the "entering bhaal temple" cutscene

#include "hf_in_cutscene"
#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SetLocalInt(GetModule(), "iEnteredCellar", 1);
        SpawnEnter(oPC);
        if (GetLocalInt(OBJECT_SELF, "nPlayedScene") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPlayedScene", 1);
            CutscenePlay(oPC, "mv_ar1301a_1");
        }
    }
}
