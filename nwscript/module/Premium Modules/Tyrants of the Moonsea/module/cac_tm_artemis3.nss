//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_artemis3
// DATE: November 19, 2005
// AUTH: Luke Scull
// NOTE: Artemis will now help PC if they fight Grazkahn.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
SetLocalInt(GetPCSpeaker(), "artemishelp", 1);

DestroyObject(OBJECT_SELF, 0.5);
}
