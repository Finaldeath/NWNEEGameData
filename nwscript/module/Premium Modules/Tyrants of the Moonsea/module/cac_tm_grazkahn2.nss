//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn2
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal; player has given Kazz's sword
//       to Grazkahn and completed the quest.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    int nXP;

    object oPC = GetPCSpeaker();
    object oItemToTake;

    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "HellforgedSword");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    //Update journal and give quest completion xp
    AddJournalQuestEntry("FiendsAtWar", 22, oPC, TRUE, FALSE, TRUE);
    nXP = GetJournalQuestExperience("FiendsAtWar");
    GiveXPToCreature(oPC, nXP);
}
