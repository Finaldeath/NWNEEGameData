// lyressa opens dragoth's exterior door

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oLyressa = GetNearestObjectByTag("Lyressa", oPC);
    if (GetIsObjectValid(oLyressa))
    {
        object oDoor = GetNearestObjectByTag("DragothKeepIN", oPC);
        if (GetIsObjectValid(oDoor))
        {
            SetLocked(oDoor, FALSE);
            AssignCommand(oDoor, ActionOpenDoor(oDoor));
            if (PlotLevelGet("DragothTheBoneMage") == 0)
            {
                PlotLevelSet("DragothTheBoneMage", 1);
                AddJournalQuestEntry("DragothTheBoneMage", 10, oPC);
            }
        }
    }
}
