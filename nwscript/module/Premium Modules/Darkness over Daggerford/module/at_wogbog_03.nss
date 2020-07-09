void main()
{
    object oPC = GetPCSpeaker();
    string sFoodTag;
    int n = GetLocalInt(OBJECT_SELF, "HF_ARG");
    if (n == 1) sFoodTag = "db_bread2";
    if (n == 2) sFoodTag = "db_bread1";
    if (n == 3) sFoodTag = "db_toffeeapple";
    object oFood = GetItemPossessedBy(oPC, sFoodTag);
    if (GetIsObjectValid(oFood))
    {
        AdjustAlignment(oPC, ALIGNMENT_GOOD, 1);
        GiveXPToCreature(oPC, 50);
        DestroyObject(oFood);
    }
}
