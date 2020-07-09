// puzzle: the door opens

void main()
{
    object oDoor = OBJECT_SELF;
    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
