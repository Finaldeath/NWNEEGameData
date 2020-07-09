//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_cheswick4
// DATE: December 26, 2005
// AUTH: Luke Scull
// NOTE: Jumps all NPCs to their appropriate locations
//       during a quick screen fade.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
// Define all objects in scripts

object oWife = GetObjectByTag("Amberlyn");

object oOx1 = GetObjectByTag("HillsfarOx1");

object oOx2 = GetObjectByTag("HillsfarOx2");

object oWaypoint1 = GetObjectByTag("WP_CheswicksWife_Jump");

object oWaypoint2 = GetObjectByTag("WP_Cheswick_Jump");

object oWaypoint3 = GetObjectByTag("WP_HillsfarOx1_Jump");

object oWaypoint4 = GetObjectByTag("WP_HillsfarOx2_Jump");

// Fade out screen and jump objects to their correct positions

FadeToBlack(GetFirstPC(), FADE_SPEED_MEDIUM);

DelayCommand(1.0, AssignCommand(oWife, JumpToObject(oWaypoint1)));

DelayCommand(1.1, AssignCommand(oOx1, JumpToObject(oWaypoint3)));

DelayCommand(1.2, AssignCommand(oOx2, JumpToObject(oWaypoint4)));

DelayCommand(1.3, JumpToObject(oWaypoint2));

DelayCommand(2.5, FadeFromBlack(GetFirstPC(), FADE_SPEED_MEDIUM));

object oPC = GetFirstPC();

object oEremuth = GetObjectByTag("Eremuth");

SetLocalInt(oPC, "eremuthsuspicious", 1);

DelayCommand(3.5, AssignCommand(oPC, ClearAllActions()));

DelayCommand(3.5, AssignCommand(oEremuth, ClearAllActions()));

DelayCommand(3.6, AssignCommand(oEremuth, ActionStartConversation(oPC, "tm_hench_eremuth")));
}
