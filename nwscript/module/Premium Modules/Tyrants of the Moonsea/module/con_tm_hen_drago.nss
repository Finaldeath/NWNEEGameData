//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_drago
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether:
//:: - PC is in Dragoths Keep
//:: - Dragoth the bone mage quest isn't finished
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string AREA_TAG = "ThentiaDragothKeep";


int IsQuestInProgress(object oPC)
{
    return ( (PlotLevelGet("Dragoth") < 5) && // Peaceful resolution == 6
             (PlotLevelGet("DragothTheBoneMage") < 3) ); // Dragoth has been attacked == 3
}


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return ( HenchmanIsMine(oHench, oPC) &&
             IsQuestInProgress(oPC) &&
             (GetTag(GetArea(oPC)) == AREA_TAG));
}
