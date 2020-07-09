void main()
{
object oAstar = GetObjectByTag("Astar");

object oEremuth = GetObjectByTag("Eremuth");

object oLyressa = GetObjectByTag("Lyressa");

object oWaypoint1 = GetObjectByTag("WP_Astar_Swaying");

object oWaypoint2 = GetObjectByTag("WP_Eremuth_Swaying");

object oWaypoint3 = GetObjectByTag("WP_Lyressa_Swaying");

AssignCommand(oAstar, JumpToObject(oWaypoint1));

AssignCommand(oEremuth, JumpToObject(oWaypoint2));

AssignCommand(oLyressa, JumpToObject(oWaypoint3));

}
