
// adjust the player's alignment by a certain value
void AdjustPlayerAlignment(object oPC, int nAlignment, int nAmount)
{
    string sAlignment = "";
    if (nAlignment == ALIGNMENT_GOOD) sAlignment = "Good";
    if (nAlignment == ALIGNMENT_EVIL) sAlignment = "Evil";
    if (nAlignment == ALIGNMENT_LAWFUL) sAlignment = "Lawful";
    if (nAlignment == ALIGNMENT_CHAOTIC) sAlignment = "Chaotic";
    string sMsg = "Alignment Shift: " + IntToString(nAmount) + " towards " + sAlignment;
    FloatingTextStringOnCreature(sMsg, oPC);
    AdjustAlignment(oPC, nAlignment, nAmount);
}
