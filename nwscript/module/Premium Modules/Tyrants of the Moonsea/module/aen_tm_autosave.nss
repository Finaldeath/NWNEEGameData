//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: aen_tm_autosave
// DATE: 30 June, 2006
// AUTH: Luke Scull
// NOTE: Autosaves the first time player enters area.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();
if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nRunSaveOnce")!= 1)
{
SetLocalInt(OBJECT_SELF, "nRunSaveOnce", 1);
DoSinglePlayerAutoSave();
}
}
