// does the player have at least one henchman?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = GetHenchman(oPC);
    return(GetIsObjectValid(oHench));
}
