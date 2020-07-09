// pirates of the moonsea:
// the player has spoken with the admiral; kettia wants to leave

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    return (GetTag(oArea) == "MelNavy");
}
