// B W-Husey
// March 2006
// The Player has chosen to fight the Witch Lord for the right to do what they want with the Crown
// We often default to this state and reset later, as this can be the end result of many choices.

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"nFinishState",2);
}
