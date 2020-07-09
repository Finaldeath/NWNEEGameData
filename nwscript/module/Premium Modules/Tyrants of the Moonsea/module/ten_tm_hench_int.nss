//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_hench_int
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Set Henchmen Interjection level
//:: Get both interjecting NPC and interjection level
//:: (= dialog branch) from local variable.
//:: Set intersection level as plot variable on module
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"


const string HENCH_TAG_LYRESSA = "Lyressa";
const string HENCH_TAG_SHARALYN = "SharalynHenchman";
const string HENCH_TAG_BEIRMOURA = "Beirmoura";

string LVAR_HENCH_INTERSECT_LEVEL = "hench_intersect_lvl";
string LVAR_HENCH_INTERSECT_CURRENT_LVL = "hench_intersect_cnt";
string LVAR_HENCH_INTERSECT_TAG = "hench_intersect_tag";

const float JUMP_DISTANCE = 2.0f; // Jumps the NPCs in, if too far away


string GetInterjectionDialog(string sHenchTag)
{
    if (sHenchTag == HENCH_TAG_LYRESSA)
    {
        return "tm_hench_in_lyre";
    }
    else if (sHenchTag == HENCH_TAG_SHARALYN)
    {
        return "tm_hench_in_shara";
    }
    else if  (sHenchTag == HENCH_TAG_BEIRMOURA)
    {
        return "tm_hench_in_beir";
    }
    return "ERROR";
}


void main()
{
    object oPC = GetEnteringObject();

    string sHenchTag = GetLocalString(OBJECT_SELF, LVAR_HENCH_INTERSECT_TAG);
    object oHench = GetNearestObjectByTag(sHenchTag, oPC);

    string sDialog = GetInterjectionDialog(sHenchTag);
    int nDialogLevel = GetLocalInt(OBJECT_SELF, LVAR_HENCH_INTERSECT_LEVEL);

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0) && (GetIsObjectValid(oHench)))
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(LVAR_HENCH_INTERSECT_LEVEL, nDialogLevel);
        PlotLevelSet(LVAR_HENCH_INTERSECT_CURRENT_LVL, 0);

        SetLocalString(GetModule(), LVAR_HENCH_INTERSECT_TAG, GetTag(oHench));

        // AssignCommand(oPC, ClearAllActions(TRUE));

        AssignCommand(oHench, ClearAllActions(TRUE));
        // Jump the NPCs in, if too far away
        if (GetDistanceBetween(oHench, oPC) > JUMP_DISTANCE)
        {
            AssignCommand(oHench, JumpToLocation(GetLocation(oPC)));
        }
        DelayCommand(0.5f, AssignCommand(oHench, SpeakOneLinerConversation(sDialog, oPC)));
    }
}
