// play a cutscene when this trigger is entered
//   HF_CUTSCENE_NAME - name of the cutscene to play

#include "hf_in_cutscene"
#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            AssignCommand(oPC, ClearAllActions());
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            //Spawn Tusk's orcs
            SpawnEnter(oPC);
            //Play Tusk cutscene
            string sCutscene = GetLocalString(OBJECT_SELF, "HF_CUTSCENE_NAME");
            CutscenePlay(oPC, sCutscene);
        }
    }
}
