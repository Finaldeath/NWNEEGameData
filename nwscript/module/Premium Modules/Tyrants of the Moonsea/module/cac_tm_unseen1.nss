//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_unseen1
//:: DATE: January 25, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Opens the door to Laris Curios
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = OBJECT_SELF;

    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));

    if (PlotLevelGet("theunseen_status") < 2)
    {
        PlotLevelSet("theunseen_status", 2);
        AddJournalQuestEntry("TheUnseen", 20, oPC);
    }
}
