void main()
{
object oDoor = GetObjectByTag("Voonlar_To_TheBoringPig");

AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE));

SetPlotFlag(oDoor, FALSE);

AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF));
}
