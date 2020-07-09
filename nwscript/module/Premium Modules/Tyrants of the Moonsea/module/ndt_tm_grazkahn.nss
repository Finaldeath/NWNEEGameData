#include "x0_i0_partywide"

#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetFirstPC();

    SetLocalInt(GetModule(), "nGrazDead", 1);

    if(GetLocalInt(GetModule(), "nKazzDead") == 0)
    {
        //Killed Graz at Kazz's request
        if(PlotLevelGet("KazzTemmet") == 3)
        {
            AddJournalQuestEntry("FiendsAtWar", 11, oPC, FALSE, FALSE, TRUE);
        }
        //Kazz still alive
        else
        {
            AddJournalQuestEntry("FiendsAtWar", 30, oPC, FALSE, FALSE, TRUE);
        }
    }
    //Retrieved sword but killed Graz and knew Graz wanted sword
    else
    if((GetIsItemPossessedByParty(oPC, "HellforgedSword") &&
        PlotLevelGet("Grazkahn") == 2))
    {
        //Update journal and award 75% quest completion xp
        nXP = (GetJournalQuestExperience("FiendsAtWar") * 75) / 100;
        GiveXPToCreature(oPC, nXP);
        AddJournalQuestEntry("FiendsAtWar", 43, oPC, FALSE, FALSE, TRUE);
    }
    //Kazz dead
    else
    {
        //Update journal and award 75% quest completion xp
        nXP = (GetJournalQuestExperience("FiendsAtWar") * 75) / 100;
        GiveXPToCreature(oPC, nXP);
        AddJournalQuestEntry("FiendsAtWar", 44, oPC, FALSE, FALSE, TRUE);
    }

    PlotLevelSet("Grazkahn", 4);
}
