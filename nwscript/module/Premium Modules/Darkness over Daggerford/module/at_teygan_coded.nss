//take the coded communiques and Teygan's Map
void main()
{
    object oPC=GetPCSpeaker();
    object oCoded1=GetItemPossessedBy(oPC,"db_itnote1");
    object oCoded2=GetItemPossessedBy(oPC,"db_itnote2");
    object oMap=GetItemPossessedBy(oPC,"db_directions");
        if(GetIsObjectValid(oCoded1) != 0)
        {
            DestroyObject(oCoded1);
        }
        if(GetIsObjectValid(oCoded2) != 0)
        {
            DestroyObject(oCoded2);
        }
        if(GetIsObjectValid(oMap) != 0)
        {
            DestroyObject(oMap);
        }
    GiveXPToCreature(oPC,1000);
    FloatingTextStringOnCreature("Coded communique delivered!",oPC);
    SetLocalInt(OBJECT_SELF, "iBurnedCommunique", 1);
}
