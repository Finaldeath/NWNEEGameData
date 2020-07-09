// lyressa underwent the ritual to become evil; she attacks dragoth
// sidequest: dragoth the bone mage

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // lyressa has done the ritual
    AddJournalQuestEntry("HenchmenLyressa", 20, oPC);
    PlotLevelSet("Dragoth", 6);
    AddJournalQuestEntry("DragothTheBoneMage", 60, oPC);
    int nXP = GetJournalQuestExperience("DragothTheBoneMage");
    GiveXPToCreature(oPC, nXP);

    // lyressa changes to an assassin; she gains at least one assassin level
    object oLyressa = GetNearestObjectByTag("Lyressa", oPC);
    if (GetIsObjectValid(oLyressa))
    {
        AdjustAlignment(oLyressa, ALIGNMENT_EVIL, 100);
        SetXP(oLyressa, 0);
        int nRogueLevels = GetLevelByClass(CLASS_TYPE_ROGUE, oLyressa);

        // give her 10 rogue levels
        int i = 0;
        for (i = 0; i < (10 - nRogueLevels); i++)
        {
            LevelUpHenchman(oLyressa, CLASS_TYPE_ROGUE, FALSE, PACKAGE_ROGUE);
        }

        // give her at least one assassin level
        int nAssLevels = nRogueLevels - 10 + 1;
        if (nAssLevels < 1)
            nAssLevels = 1;
        for (i = 0; i < nAssLevels; i++)
        {
            LevelUpHenchman(oLyressa, CLASS_TYPE_ASSASSIN, FALSE, PACKAGE_ASSASSIN);
        }
    }

    // lyressa attacks dragoth
    GoHostile(OBJECT_SELF);

    // any remaining dragoth minions go hostile
    int n = 1;
    object oUndead = GetNearestObjectByTag("DragothMinion", oPC, n);
    while (GetIsObjectValid(oUndead))
    {
        GoHostile(oUndead);
        oUndead = GetNearestObjectByTag("DragothMinion", oPC, ++n);
    }
    object oJeeves = GetNearestObjectByTag("Jeeves", oPC);
    GoHostile(oJeeves);
}
