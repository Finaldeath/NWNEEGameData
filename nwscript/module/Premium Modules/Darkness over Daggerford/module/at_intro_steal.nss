//steal Falias' invisibilty cloak
//Damian Brown (Luspr)
void main()
{
    object oPC=GetPCSpeaker();
    CreateItemOnObject("db_faliascloak",oPC,1);
    FloatingTextStringOnCreature("Successful use of Rogue Skill.",oPC);
    GiveXPToCreature(oPC,50);
}
