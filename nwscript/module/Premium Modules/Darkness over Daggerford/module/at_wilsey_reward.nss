void main()
{
    object oPC=GetPCSpeaker();
    FloatingTextStringOnCreature("Mayor Wilsey is satisfied and gives you the key.",oPC);
    if(GetLocalInt(GetModule(), "render") != 2)
    {
        GiveXPToCreature(oPC,500);
    }
    else
    {
        GiveXPToCreature(oPC, 250);
    }
    CreateItemOnObject("db_stronghold",oPC,1);
    SetLocalInt(GetModule(),"mayor_wilsey",3);
    SetMapPinEnabled(GetWaypointByTag("NW_MAPNOTE_LHTEMPLE"), FALSE);
    SetMapPinEnabled(GetWaypointByTag("NW_MAPNOTE_STRONGHOLD"), TRUE);
}
