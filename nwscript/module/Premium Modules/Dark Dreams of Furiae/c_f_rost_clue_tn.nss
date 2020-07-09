int StartingConditional()
{
    return (GetLocalInt(GetModule(), "ddf_rooster_clue_count") < 3 && GetLocalInt(OBJECT_SELF, "kyla_spoke") == FALSE);
}

