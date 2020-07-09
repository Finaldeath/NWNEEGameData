void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    int nDungeon;
    int nModule;

    // greeting
    nDungeon = GetLocalInt(oImport, "nListCasterGreeting");
    nModule = GetLocalInt(GetModule(), "nLinesCasterGreetingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // description
    nDungeon = GetLocalInt(oImport, "nListCasterDescription");
    nModule = GetLocalInt(GetModule(), "nLinesCasterDescriptionNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // question
    nDungeon = GetLocalInt(oImport, "nListCasterQuestion");
    nModule = GetLocalInt(GetModule(), "nLinesCasterQuestionNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // healing
    nDungeon = GetLocalInt(oImport, "nListCasterHealing");
    nModule = GetLocalInt(GetModule(), "nLinesCasterHealingNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // remainder
    nDungeon = GetLocalInt(oImport, "nListCasterRemainder");
    nModule = GetLocalInt(GetModule(), "nLinesCasterRemainderNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // spells
    nDungeon = GetLocalInt(oImport, "nListCasterSpells");
    nModule = GetLocalInt(GetModule(), "nLinesCasterSpellsNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // cast
    nDungeon = GetLocalInt(oImport, "nListCasterCast");
    nModule = GetLocalInt(GetModule(), "nLinesCasterCastNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }

    // farewell
    nDungeon = GetLocalInt(oImport, "nListCasterFarewell");
    nModule = GetLocalInt(GetModule(), "nLinesCasterFarewellNum");
    if (nDungeon > nModule)
    {
        bFail = TRUE;
    }


    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
