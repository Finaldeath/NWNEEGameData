// does the player have the correct ingredients to make an item?

#include "hf_in_forge"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (ForgeCanDisplay(OBJECT_SELF, 2))
    {
        return(ForgeHasIngredients(OBJECT_SELF, oPC, 2));
    }
    return(FALSE);
}
