//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovate1
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: Pause conversation then have golems move
//       towards player before unpausing.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetFirstPC();

    object oLeft = GetObjectByTag("Left");

    object oRight = GetObjectByTag("Right");

    ActionPauseConversation();

    AssignCommand(oLeft, ActionForceMoveToObject(oPC, FALSE, 1.0));

    AssignCommand(oRight, ActionForceMoveToObject(oPC, FALSE, 1.0));

    DelayCommand(5.0, ActionResumeConversation());
}
