//give PC experience for telling Frederick that Griffons are Zhents.
void main()
{
    object oPC = GetPCSpeaker();
    GiveXPToCreature(oPC,750);
    FloatingTextStringOnCreature("You convinced Frederick that the Griffons are Zhents.",oPC);
}
