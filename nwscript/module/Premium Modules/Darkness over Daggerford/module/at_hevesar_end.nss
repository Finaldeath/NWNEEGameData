void main()
{
    object oPC=GetPCSpeaker();
    SetLocalInt(GetModule(),"hevesar_quest",5);
    GiveGoldToCreature(oPC,700);
    GiveXPToCreature(oPC,2500);
    FloatingTextStringOnCreature("You have completed Hevesar's quests.",oPC);

}
