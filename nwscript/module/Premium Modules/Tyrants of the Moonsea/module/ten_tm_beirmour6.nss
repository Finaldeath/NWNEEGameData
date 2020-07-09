//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_beirmour6
//:: DATE: February 23, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Triggers final Beirmoura interjection just before
//:: leaving the Grand temple
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_BEIRMOURA = "hench_dialog_beirmoura";

const string NPC_TAG_BEIRMOURA = "Beirmoura";

void main()
{
    object oPC = GetEnteringObject();
    object oBeirmoura = GetNearestObjectByTag(NPC_TAG_BEIRMOURA, oPC);

    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0) && GetIsObjectValid(oBeirmoura) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(PLOT_DIALOG_BEIRMOURA, 6);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 2.0);

        AssignCommand(oBeirmoura, ActionStartConversation(oPC));
    }
}
