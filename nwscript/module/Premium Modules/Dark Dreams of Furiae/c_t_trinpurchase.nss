int StartingCondition()
{
    if (GetLocalInt(GetModule(), "ddf_trin_purchase"))
        return TRUE;

    return FALSE;
}
