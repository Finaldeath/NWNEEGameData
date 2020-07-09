// pirates of the moonsea:
// the player has fought the marels; kettia wants to leave

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    return (GetTag(oArea) == "area102");
}
