//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_pitfiend1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Player has now spoken with Pit Fiend.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oDoor = GetObjectByTag("WaksElectricalDoor");

ActionPauseConversation();

SetFacingPoint(GetPosition(oDoor));

SetTrapDisabled(oDoor);

SetLocalInt(GetPCSpeaker(), "jeeves", 1);

DelayCommand(2.0, SetFacingPoint(GetPosition(GetPCSpeaker())));

DelayCommand(2.5, ActionResumeConversation());
}
