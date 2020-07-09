//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_lyressa5
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Triggers Lyressa interjection after Dragoth quest
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

const string NPC_TAG_LYRESSA = "Lyressa";


int IsQuestFinished(object oPC)
{
    return ( (PlotLevelGet("Dragoth") >= 5) || //Peaceful resolution == 6
             (PlotLevelGet("DragothTheBoneMage") >= 3) ); // Dragoth has been attacked == 3
}


void main()
{
    object oPC = GetEnteringObject();
    object oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);

    if ( GetIsPC(oPC) &&
         GetIsObjectValid(oLyressa) &&
         (GetLocalInt(OBJECT_SELF, "nDone") == 0) &&
         IsQuestFinished(oPC) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(PLOT_DIALOG_LYRESSA, 5);

        AssignCommand(oPC, ClearAllActions(TRUE));

        AssignCommand(oLyressa, ClearAllActions(TRUE));
        DelayCommand(0.4f, AssignCommand(oLyressa, JumpToLocation(GetLocation(oPC))));
        DelayCommand(0.8f, AssignCommand(oLyressa, ActionStartConversation(oPC, "")));
    }
}
