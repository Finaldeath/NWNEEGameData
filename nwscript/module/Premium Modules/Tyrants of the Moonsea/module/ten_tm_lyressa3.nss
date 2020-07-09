//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_lyressa3
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Lyressa Interjection when leaving Voonlar
//:: without talking to her first.
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";

const string NPC_RESREF_LYRESSA = "lyressa";
const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_VOONLAR = "WP_voonlyres_lyressa_spawn";

const string WP_TAG_LYRESSA_BORINGPIT = "WP_voon_bpi_lyressa";


void main()
{
    object oPC = GetEnteringObject();
    int nLyressaTalkedTo = (PlotLevelGet(PLOT_DIALOG_LYRESSA) >= 1);
    object oLyressa = OBJECT_INVALID;

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0) && (!nLyressaTalkedTo))
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        PlotLevelSet(PLOT_DIALOG_LYRESSA, 3);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 3.0);

        // Destroy Lyressa in the Boring Pit (restored in cac_tm_lyressa3)
        object oWpLyressaBoringP = GetWaypointByTag(WP_TAG_LYRESSA_BORINGPIT);
        oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oWpLyressaBoringP);
        if (GetIsObjectValid(oLyressa))
            DestroyObject(oLyressa);

        // Create Lyressa to talk to
        object oWpLyressaVoonlar = GetWaypointByTag(WP_TAG_LYRESSA_VOONLAR);
        oLyressa = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_LYRESSA, GetLocation(oWpLyressaVoonlar));
        AssignCommand(oLyressa, ActionStartConversation(oPC));
    }
}
