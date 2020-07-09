int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "ks_wogbogs_stick");
    return(GetIsObjectValid(oStick));
}
