// pirates of the moonsea
// update journal when veris dies

/*
Veris = 1                   talked to veris
Veris = 2                   veris gave the player his ring
Veris = 3                   veris fight
*/

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    PlotLevelSet("VerisDead", 1);

    //Only update journal if Veris has not previously come to peaceful agreement
    //with PC (as death will then be in Naval Battle)
    if(PlotLevelGet("Veris") != 2)
    {
        AddJournalQuestEntry("PiratesoftheMoonsea", 30, oPC, TRUE, FALSE, TRUE);
    }
}
