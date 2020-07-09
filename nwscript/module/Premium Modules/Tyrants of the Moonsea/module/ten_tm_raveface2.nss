//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_raveface2
// DATE: October 31, 2005
// AUTH: Luke Scull
// NOTE: Sets raven facing player.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

if ((GetEnteringObject()) != GetObjectByTag("ShadowRaven")) return;

object oRaven = GetObjectByTag("ShadowRaven");

AssignCommand(oRaven, ClearAllActions());

DelayCommand(1.0, AssignCommand(oRaven, SetFacing(135.0)));

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
}
