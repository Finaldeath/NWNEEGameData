//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_sharalyn6
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Triggers final Sharalyn interjection just before
//:: leaving the Grand temple
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

const string NPC_TAG_SHALARYN = "SharalynHenchman";

void main()
{
    object oPC = GetEnteringObject();
    object oSharalyn = GetNearestObjectByTag(NPC_TAG_SHALARYN, oPC);

    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0) && GetIsObjectValid(oSharalyn) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(PLOT_DIALOG_SHARALYN, 6);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 2.0);

        AssignCommand(oSharalyn, ActionStartConversation(oPC));
    }
}
