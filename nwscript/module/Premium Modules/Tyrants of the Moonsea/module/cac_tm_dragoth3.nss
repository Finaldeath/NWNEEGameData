// player has spoken with jeeves and now knows about dragoth and lyressa
// sidequest: dragoth the bone mage

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    if (PlotLevelGet("DragothTheBoneMage") < 2)
    {
        PlotLevelSet("DragothTheBoneMage", 2);
        AddJournalQuestEntry("DragothTheBoneMage", 20, oPC);
    }
}
