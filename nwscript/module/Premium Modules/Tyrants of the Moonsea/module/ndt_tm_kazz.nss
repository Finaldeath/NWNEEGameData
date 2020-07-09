//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_kazz
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Updates journal on Kazz's death, depending on
//       current quest state. See commenting.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetFirstPC();

    SetLocalInt(GetModule(), "nKazzDead", 1);

    if(GetLocalInt(GetModule(), "nGrazDead") == 1)
    {
        //Update journal and award 75% quest completion xp
        nXP = (GetJournalQuestExperience("FiendsAtWar") * 75) / 100;
        GiveXPToCreature(oPC, nXP);
        //Killed Graz at Kazz's request
        if(PlotLevelGet("KazzTemmet") == 3)
        {
            AddJournalQuestEntry("FiendsAtWar", 12, oPC, FALSE, FALSE, TRUE);
        }
        //Killed Graz not at Kazz's request but talked to Kazz
        else if(PlotLevelGet("KazzTemmet") == 2)
        {
            AddJournalQuestEntry("FiendsAtWar", 32, oPC, FALSE, FALSE, TRUE);
        }
        //Killed Kazz without talking
        else
        {
            AddJournalQuestEntry("FiendsAtWar", 50, oPC, FALSE, FALSE, TRUE);
        }
    }
    else
    //Asked Kazz for sword
    if(PlotLevelGet("Grazkahn") == 2)
    {
        AddJournalQuestEntry("FiendsAtWar", 34, oPC, FALSE, FALSE, TRUE);
    }
    //Refused to kill Grazkahn having been told about him
    else if(PlotLevelGet("KazzTemmet") > 1)
    {
        AddJournalQuestEntry("FiendsAtWar", 40, oPC, FALSE, FALSE, TRUE);
    }
    //Killed Kazz without talking
    else
    {
        AddJournalQuestEntry("FiendsAtWar", 45, oPC, FALSE, FALSE, TRUE);
    }
    PlotLevelSet("KazzTemmet", 4);
    ExecuteScript("nw_s3_balordeth", OBJECT_SELF);
}
