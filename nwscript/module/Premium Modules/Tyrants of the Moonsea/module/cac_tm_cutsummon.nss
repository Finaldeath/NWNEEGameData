// play Orcus summoning cutscene when this dialog branch is selected

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            CutscenePlay(oPC, "cut_tm_ktsummon");
        }
    }
}
