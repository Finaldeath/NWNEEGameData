//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_endvoonqs
// DATE: September 29, 2005
// AUTH: Luke Scull
// NOTE: Finishes final "Voonlar" journal entry and
//       awards 2,500 xp
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    // I think I checked to see if journal was already on 50 so reward isn't
    // repeated if player cancels out of dialogue and does it again
    if (GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar")< 50)
    {
        int nXP;

        AddJournalQuestEntry("Voonlar", 50, oPC);
        nXP = GetJournalQuestExperience("Voonlar");
        GiveXPToCreature(oPC, nXP);
    }
}
