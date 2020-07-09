// does the player have the correct ingredients to make an item?

#include "hf_in_forge"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (ForgeCanDisplay(OBJECT_SELF, 1))
    {
        return(ForgeHasIngredients(OBJECT_SELF, oPC, 1));
    }
    return(FALSE);
}
