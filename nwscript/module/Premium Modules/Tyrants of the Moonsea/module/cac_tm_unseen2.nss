//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_unseen2
//:: DATE: January 26, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: The Unseen
//:: Open the door to the Melvaunt warehouse
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = OBJECT_SELF;

    SetLocked(oDoor, FALSE);
    DelayCommand(0.2f, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));

    if (PlotLevelGet("theunseen_status") < 4)
    {
        PlotLevelSet("theunseen_status", 4);
        AddJournalQuestEntry("TheUnseen", 40, oPC);
    }

}
