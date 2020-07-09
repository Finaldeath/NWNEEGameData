int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, "nRecipeOffset") > 0)
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
