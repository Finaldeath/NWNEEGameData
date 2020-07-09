// dla_trigmanmake1
// October 2005
// B W-Husey
// If a picket enters the trigger, create an artillerist to shoot the ballista, lock the tower and sound the (local) alarm

void main()
{
    object oHob = GetEnteringObject();
    if (GetTag(oHob) == "Picket" && GetLocalInt(OBJECT_SELF,"nOnce")==0) // a picket entered the trigger
    {
        object oDoor = GetObjectByTag("PFAEntrance") ;
        location lLoc = GetLocation(GetWaypointByTag("SpawnArt1"));
        AssignCommand(oDoor,ActionOpenDoor(OBJECT_SELF));         //open the tower door
        CreateObject(OBJECT_TYPE_CREATURE,"artillerist",lLoc,FALSE,"Shooter");    //make the artillerist
        DelayCommand(0.2,AssignCommand(GetObjectByTag("Shooter"),ActionInteractObject(GetNearestObjectByTag("Ballista"))));
        DelayCommand(3.0,AssignCommand(oDoor,ActionCloseDoor(OBJECT_SELF)));         //close the tower door
        DelayCommand(3.5,SetLocked(oDoor,TRUE));         //bar the door
        SetLocalInt(OBJECT_SELF,"nOnce",1);
        object oSound = GetNearestObjectByTag("Playsound");
        SoundObjectPlay(oSound); //play the sound
        DelayCommand(6.0,SoundObjectStop(oSound));//stop the sound
        DestroyObject(OBJECT_SELF,6.0);
    }
}
