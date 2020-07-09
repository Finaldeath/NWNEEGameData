void main()
{
object oPC = GetPCSpeaker();

object oWaypoint = GetObjectByTag("WP_BOUGH_JUMP");

AssignCommand(oPC, JumpToObject(oWaypoint));
}
