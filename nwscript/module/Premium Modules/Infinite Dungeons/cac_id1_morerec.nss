void main()
{
    int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    nRecipeOffset += 10;
    SetLocalInt(OBJECT_SELF, "nRecipeOffset", nRecipeOffset);
}
