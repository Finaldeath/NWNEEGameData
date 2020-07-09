int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTorch = GetItemPossessedBy(oPC, "NW_IT_TORCH001 ");
    return(GetIsObjectValid(oTorch));
}
