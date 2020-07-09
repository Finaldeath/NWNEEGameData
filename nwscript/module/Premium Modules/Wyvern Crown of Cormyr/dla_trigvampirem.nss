// February 2006
// B W-Husey
// 'Wakes' the vampires and makes them attack - unlocks their doors, sets their tags
// to match coffins, and plays sounds.

void main()
{
    if (GetLocalInt(OBJECT_SELF,"Fired")<1)
    {
    object oPC = GetEnteringObject();
    //Spawn locations
    location lLoc1 = GetLocation(GetWaypointByTag("WP_Vamp1"));
    location lLoc2 = GetLocation(GetWaypointByTag("WP_Vamp2"));
    location lLoc3 = GetLocation(GetWaypointByTag("WP_Vamp3"));
    location lLoc4 = GetLocation(GetWaypointByTag("WP_Vamp4"));
    location lSkull =  GetLocation(GetWaypointByTag("WP_Skullpoint"));
    // Vampires & visual
    object oVamp1 = CreateObject(OBJECT_TYPE_CREATURE,"vampire1",lLoc1,TRUE,"Vampire1");
    object oVamp2 = CreateObject(OBJECT_TYPE_CREATURE,"vampire2",lLoc2,TRUE,"Vampire2");
    object oVamp3 = CreateObject(OBJECT_TYPE_CREATURE,"vampire3",lLoc3,TRUE,"Vampire3");
    object oVamp4 = CreateObject(OBJECT_TYPE_CREATURE,"vampire4",lLoc4,TRUE,"Vampire4");
    object oSkull = CreateObject(OBJECT_TYPE_PLACEABLE,"wcskull",lSkull);
    AssignCommand(oSkull,DestroyObject(OBJECT_SELF,5.0));
    // Play sounds
    SoundObjectPlay(GetNearestObjectByTag("VampSound"));
    SoundObjectPlay(GetNearestObjectByTag("VampSound",OBJECT_SELF,2));
    SoundObjectPlay(GetNearestObjectByTag("VampSound",OBJECT_SELF,3));
    SoundObjectPlay(GetNearestObjectByTag("VampSound",OBJECT_SELF,4));
    // Unlock doors
    SetLocked(GetObjectByTag("PFUDoorVamp1"),FALSE);
    SetLocked(GetObjectByTag("PFUDoorVamp2"),FALSE);
    SetLocked(GetObjectByTag("PFUDoorVamp3"),FALSE);
    SetLocked(GetObjectByTag("PFUDoorVamp4"),FALSE);
    // Get vampires to attack
    AssignCommand(oVamp1,DelayCommand(2.0,ActionAttack(oPC)));
    AssignCommand(oVamp2,DelayCommand(2.0,ActionAttack(oPC)));
    AssignCommand(oVamp3,DelayCommand(2.0,ActionAttack(oPC)));
    AssignCommand(oVamp4,DelayCommand(2.0,ActionAttack(oPC)));
    // Get rid of this trigger
    SetLocalInt(OBJECT_SELF,"Fired",1);
    }
}
