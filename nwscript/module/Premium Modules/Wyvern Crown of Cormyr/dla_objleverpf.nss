// January 2006
// B W-Husey
// Opens/locks PF Drawbridge

void main()
{

object oDraw1 = GetObjectByTag("PFDrawBridgeIn");
object oDraw2 = GetObjectByTag("PFDrawBridgeOut");
DelayCommand(5.2,SetLocked(oDraw1,TRUE));
DelayCommand(5.2,SetLocked(oDraw2,TRUE));

int nDoorLocked;
int nDoorOpen; //Is the door opened already?
string sDoorTag; //testing variable

if ( GetIsObjectValid (oDraw2) == TRUE )
{    sDoorTag = GetTag (oDraw2);
    nDoorLocked = GetLocked (oDraw2);
    nDoorOpen = GetIsOpen (oDraw2);
    //This part simply switches the graphics on the lever from activate to//deactivate or vice versa.
    if ( GetLocalInt ( OBJECT_SELF, "m_bActivated" )==TRUE)
    {
        SetLocalInt (OBJECT_SELF,"m_bActivated",FALSE);
        ActionPlayAnimation ( ANIMATION_PLACEABLE_ACTIVATE);
    }
    else if ( GetLocalInt (OBJECT_SELF,"m_bActivated") ==FALSE)
    {    SetLocalInt (OBJECT_SELF,"m_bActivated",TRUE);
         ActionPlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE);
    }
    /* this part checks if the door is locked and close if it is
    it unlocks and opens.If it is open and unlocked then it closes
    and locks it.*/
    if ( nDoorLocked && nDoorOpen==FALSE)
    {
        SetLocked ( oDraw2,FALSE );
        ActionOpenDoor ( oDraw2 );
        SetLocked ( oDraw1,FALSE );
        ActionOpenDoor ( oDraw1 );
    }
    else if ( nDoorOpen && nDoorLocked==FALSE)
    {
        ActionCloseDoor (oDraw2);
        SetLocked (oDraw2,TRUE);
        ActionCloseDoor (oDraw1);
        SetLocked (oDraw1,TRUE);
    }
    else if ( nDoorOpen==FALSE && nDoorLocked==FALSE)
    {
        ActionOpenDoor (oDraw2);
        ActionOpenDoor (oDraw1);
    }
}
}
