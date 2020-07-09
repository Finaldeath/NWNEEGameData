void main()
{
    object oPC=GetPCSpeaker();
    TakeGoldFromCreature(5,oPC,TRUE);
    CreateItemOnObject("db_holdfastkey",oPC,1);
}
