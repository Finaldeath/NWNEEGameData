// pirates of the moonsea
// update journal when ilandra dies

/*
IlandraPirate = 1           player convinced ilandra and blizzard to skip town (they are gone)
IlandraPirate = 2           ilandra gave her ring to the player
IlandraPirate = 3           ilandra attacked the player
IlandraPirate = 4           player gave her ring to dryden
IlandraPirate = 5           player gave her ring to dryden and ilandra has promised a favour
*/

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    PlotLevelSet("IlandraDead", 1);

    //If Ilandra has been persuaded to leave, or given PC her ring,
    //don't update journal on death (as death will then be in Naval Battle)
    if(PlotLevelGet("IlandraPirate") == 0 || PlotLevelGet("IlandraPirate") == 3)
    {
        AddJournalQuestEntry("PiratesoftheMoonsea", 40, oPC, TRUE, FALSE, TRUE);
    }
}
