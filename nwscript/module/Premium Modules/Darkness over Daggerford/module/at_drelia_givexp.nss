//wrap up of Teygan plot if Harpers go to cave with PC
void main()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(OBJECT_SELF, "iDreliaGiveLetter") == 0)
    {
        SetLocalInt(OBJECT_SELF, "iDreliaGiveLetter", 1);
        CreateItemOnObject("db_teyganletter",oPC,1);
        //GiveXPToCreature(oPC,2000);
        //FloatingTextStringOnCreature("You discovered Teygan's true identity.",oPC);
    }
}
