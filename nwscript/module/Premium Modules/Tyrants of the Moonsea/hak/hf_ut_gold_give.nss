// conversation action: give some gold to the player
//   HF_GOLD_AMOUNT - amount of gold to give

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    if (nGold > 0)
    {
        GiveGoldToCreature(oPC, nGold);
    }
}
