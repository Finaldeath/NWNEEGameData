void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            AssignCommand(oPC, PlaySound("it_coins"));
            GiveGoldToCreature(oPC, d10(10)+25);
            DestroyObject(OBJECT_SELF);
        }
    }
}
