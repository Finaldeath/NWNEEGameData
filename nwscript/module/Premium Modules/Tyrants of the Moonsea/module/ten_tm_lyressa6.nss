//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_lyressa6
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Triggers final Lyressa interjection just before
//:: leaving the Grand temple
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

const string NPC_TAG_LYRESSA = "Lyressa";

void main()
{
    object oPC = GetEnteringObject();
    object oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);

    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0) && GetIsObjectValid(oLyressa) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(PLOT_DIALOG_LYRESSA, 6);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 2.0);

        AssignCommand(oLyressa, ActionStartConversation(oPC));
    }
}
