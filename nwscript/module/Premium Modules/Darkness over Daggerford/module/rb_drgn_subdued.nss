void main()
{
    object oPC = GetFirstPC();

    GiveXPToCreature(oPC, 500);
    FloatingTextStringOnCreature("Dragon subdued - received 500XP!", oPC);
    SetLocalInt(GetModule(), "iSulfurusSubdued", 1);
    DestroyObject(OBJECT_SELF);
}
