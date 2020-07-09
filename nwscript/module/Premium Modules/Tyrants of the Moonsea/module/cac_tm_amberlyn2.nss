//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_amberlyn2
// DATE: January 1, 2006
// AUTH: Luke Scull
// NOTE: Fade out screen then jump both player and
//       Amberlyn to trigger next to Ogson.
//       Conversation fires.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

// define objects

object oPC = GetFirstPC();

object oWife = GetObjectByTag("Amberlyn");

object oWaypoint1 = GetObjectByTag("WP_CheswicksWife_Jump2");

object oWaypoint2 = GetObjectByTag("WP_Player_OgsonJump");

object oCheswick = GetObjectByTag("MerchantCheswick");

SetLocalInt(oPC, "amberlynrescued", 1);

//Fade out screen

FadeToBlack(oPC, FADE_SPEED_MEDIUM);

// Destroy Cheswick who is still outside Yulash and jump PC and Amberlyn there

DestroyObject(oCheswick);

DelayCommand(1.0, AssignCommand(oWife, JumpToObject(oWaypoint1)));

DelayCommand(1.1, AssignCommand(oPC, JumpToObject(oWaypoint2)));

}
