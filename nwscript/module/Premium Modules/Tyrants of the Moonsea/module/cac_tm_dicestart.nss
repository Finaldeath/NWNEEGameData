//Start a new game of 21 in the Gate of Good Fortune casino

void main()
{
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");

    object oPC = GetPCSpeaker();

    TakeGoldFromCreature(nGold, oPC, TRUE);
    DeleteLocalInt(oPC, "nRunningTotal");
    DeleteLocalInt(OBJECT_SELF, "nRunningTotal");
}
