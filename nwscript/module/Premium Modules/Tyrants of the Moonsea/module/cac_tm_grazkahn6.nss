//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn6
// DATE: November 9, 2005
// AUTH: Luke Scull
// NOTE: Update journal; player has killed Kazz and
//       claimed his sword before speaking to Grazkahn,
//       then simply given it to him when asked.
//       Complete quest.
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
