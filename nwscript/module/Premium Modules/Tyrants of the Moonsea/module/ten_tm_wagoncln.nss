//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_wagoncln
// DATE: August 26, 2005
// AUTH: Luke Scull
// NOTE: Destroy all evidence of wagon & guard.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

// Fires if PC is enters trigger...

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

// Define all targets...

object oTarget;
oTarget = GetObjectByTag("VoonlarGuardMadoc");

// Make sure the guard is not plot flagged or he won't be destroyed...

SetPlotFlag(oTarget, FALSE);

DestroyObject(oTarget, 0.1);

oTarget = GetObjectByTag("MadocsWagon");

DestroyObject(oTarget, 0.2);

oTarget = GetObjectByTag("MadocsWheel");

DestroyObject(oTarget, 0.3);

oTarget = GetObjectByTag("MadocsOx");

DestroyObject(oTarget, 0.4);

// Finally, get rid of trigger - no longer needed...

oTarget = OBJECT_SELF;

DestroyObject(oTarget, 0.5);

}

