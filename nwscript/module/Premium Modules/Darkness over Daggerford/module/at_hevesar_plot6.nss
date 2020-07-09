void main()
{
    //hevesar plots all finished - lovely
    object oPC = GetPCSpeaker();
    SetLocalInt(GetModule(), "hevesar_plot", 6);
    FloatingTextStringOnCreature("You have helped the farmers of the Sword Coast", oPC);
    GiveXPToCreature(oPC, 2500);
    SetLocalInt(oPC, "HF_DO_AUTOSAVE", 1);
}
