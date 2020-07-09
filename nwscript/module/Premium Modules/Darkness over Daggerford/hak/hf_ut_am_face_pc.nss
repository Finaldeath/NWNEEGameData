// make the speaker in a dialog face the player

void main()
{
    object oPC = GetPCSpeaker();
    SetFacingPoint(GetPosition(oPC));
}
