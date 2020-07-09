// play a cutscene when this trigger is entered
//   HF_CUTSCENE_NAME - name of the cutscene to play

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            string sCutscene = GetLocalString(OBJECT_SELF, "HF_CUTSCENE_NAME");
            CutscenePlay(oPC, sCutscene);
        }
    }
}
