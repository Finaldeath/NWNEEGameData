// B W-Husey
// October 2005
// The second of the door scripts. This one closes the door 10 seconds after it is opened, unless it was opened
// by a PC or henchman. This is useful to stop patrols revealing a whole area, but stops it interfering with combat.

void main()
{
    object oPC = GetLastOpenedBy();
    int nType = GetAssociateType(oPC);
    if (GetIsPC(oPC) == FALSE && (nType == 0)) // I have guessed that ASSOCIATE_TYPE_NONE is 0.
    {
        DelayCommand(15.0,ActionCloseDoor(OBJECT_SELF));
    }
    else DelayCommand(60.0,ActionCloseDoor(OBJECT_SELF));
}




