// has the player collected heart

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(GetIsObjectValid(GetItemPossessedBy(oPC, "rb_maerheart")));
}
