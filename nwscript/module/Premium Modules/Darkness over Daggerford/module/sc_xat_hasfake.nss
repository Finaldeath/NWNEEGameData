// has the player collected fake heart

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(GetIsObjectValid(GetItemPossessedBy(oPC, "rb_boarheart")));
}
