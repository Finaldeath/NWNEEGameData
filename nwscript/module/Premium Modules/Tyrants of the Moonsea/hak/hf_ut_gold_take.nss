// conversation action: take some gold from the player
//   HF_GOLD_AMOUNT - amount of gold to take

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");
    if (nGold > 0)
    {
        TakeGoldFromCreature(nGold, oPC);
    }
}
