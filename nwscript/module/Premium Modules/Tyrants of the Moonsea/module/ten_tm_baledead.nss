// sidequest: "thentia resistance army" - update player's journal when bale's corpse is found

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        if (PlotLevelGet("Bale") == 5)
        {
            PlotLevelSet("Bale", 6);
            AddJournalQuestEntry("ThentiasResistanceArmy", 50, oPC);
            AddJournalQuestEntry("ShadovarSearchParty", 20, oPC);
            int nXP = GetJournalQuestExperience("ThentiasResistanceArmy");
            GiveXPToCreature(oPC, nXP);
            DestroyObject(OBJECT_SELF);
        }
    }
}

