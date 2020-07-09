//Close an opened door after 20 seconds
void main()
{
    object oDoor = OBJECT_SELF;

    DelayCommand(20.0, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
}
