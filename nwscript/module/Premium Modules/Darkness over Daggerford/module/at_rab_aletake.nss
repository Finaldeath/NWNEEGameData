void main()
{
    object oPC=GetPCSpeaker();
    object oAle=GetItemPossessedBy(oPC,"db_ivusale");
        if(GetIsObjectValid(oAle) != 0)
        {
            DestroyObject(oAle);
        }
    GiveXPToCreature(oPC,300);
    FloatingTextStringOnCreature("Ale safely delivered.",oPC);
}
