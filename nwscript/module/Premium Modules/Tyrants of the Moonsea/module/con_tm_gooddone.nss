//Has a good alignment adjust been done for this character?
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "nGoodAdjust") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
