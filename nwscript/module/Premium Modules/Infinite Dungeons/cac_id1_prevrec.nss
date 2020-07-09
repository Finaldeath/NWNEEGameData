void main()
{
    int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    nRecipeOffset -= 10;
    if (nRecipeOffset < 0)
    {
        nRecipeOffset = 0;
    }
    SetLocalInt(OBJECT_SELF, "nRecipeOffset", nRecipeOffset);
}
