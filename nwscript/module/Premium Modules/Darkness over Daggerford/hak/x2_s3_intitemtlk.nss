// this is the spellscript for "talking items"
// .. the only talking item is tala, so that's all we handle here
// .. if we add more items to the game, we'll have to modify this script

#include "hf_in_talatalk"

void main()
{
    object oItem    = GetSpellCastItem();
    object oCreator = OBJECT_SELF;

    if (GetTag(oItem) == sTalaGem)
    {
        TalaTalk(oCreator);
    }
}
