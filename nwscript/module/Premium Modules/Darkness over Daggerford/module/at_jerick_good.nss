void main()
{
    object oPC = GetPCSpeaker();
    if (!GetLocalInt(OBJECT_SELF, "good_rwd") ==1)
    {
        GiveXPToCreature(oPC, 75);
        FloatingTextStringOnCreature("Set Jerick's mind at ease.", oPC);
        SetLocalInt(OBJECT_SELF, "good_rwd", 1);
    }
}
