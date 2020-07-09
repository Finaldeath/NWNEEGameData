int StartingConditional()
{
    object oPC = GetPCSpeaker();

    // umgatlik can't be dead already
    if (GetLocalInt(OBJECT_SELF, "nUmgatlikDead") != 0)
    {
        return(FALSE);
    }

    // player must have a bone
    object oBone = GetItemPossessedBy(oPC, "ks_dig_bone");
    return(GetIsObjectValid(oBone));
}
