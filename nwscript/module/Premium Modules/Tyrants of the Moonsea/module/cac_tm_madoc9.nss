//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc9
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Make guard face Madoc and gesture.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oGuard = GetObjectByTag("VoonlarGuardMadoc");

AssignCommand(oGuard, (SetFacingPoint(GetPosition(OBJECT_SELF))));

AssignCommand(oGuard, (ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
}
