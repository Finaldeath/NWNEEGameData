//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn8
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal; player has agreed to retrieve
//       Kazz's sword, given it to Grazkahn, and
//       completed quest.
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
    AddJournalQuestEntry("FiendsAtWar", 42, oPC, TRUE, FALSE, TRUE);
    nXP = GetJournalQuestExperience("FiendsAtWar");
    GiveXPToCreature(oPC, nXP);
}
