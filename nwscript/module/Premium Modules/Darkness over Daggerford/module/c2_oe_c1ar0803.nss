// onenter event of area C1AR0803

#include "hf_in_cutscene"
#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        if (!GetLocalInt(OBJECT_SELF, "pm_doorgone"))
        {
            // destroy the door, leaving behind the transition (makes it look pretty)
            SetLocalInt(OBJECT_SELF, "pm_doorgone", 1);
            DestroyObject(GetObjectByTag("C1AR0803_C1AR0800_EXIT"));
        }

        if ((GetLocalInt(GetModule(),"pm_iic_imp") || GetLocalInt(GetModule(),"pm_iic_lich")))
        {
            // play the imp-in-a-box cutscene
            if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
            {
                SpawnRemoveAllCreatures(oPC);
                SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
                CutscenePlay(oPC, "mv_ar0803_1");
            }
        }
        else
        {
            // player entered the cave without the quest
            SpawnEnter(oPC);
        }
    }
}
