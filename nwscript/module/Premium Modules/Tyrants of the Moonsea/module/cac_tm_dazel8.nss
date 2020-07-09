//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel8
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Jump PC and Dazel to wayponts in dungeon cell
//       after screen has faded. Set int so that dungeon
//       trigger fires upon being entered.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

object oWaypoint1 = GetObjectByTag("WP_Dungeon_Jump");

object oWaypoint2 = GetObjectByTag("WP_Dazel_Jump");

SetLocalInt(oPC, "dungeontrigger", 1);

FadeToBlack(oPC);

DelayCommand(1.0, ActionJumpToObject(oWaypoint2));

DelayCommand(1.5, AssignCommand(oPC, ActionJumpToObject(oWaypoint1)));
}




