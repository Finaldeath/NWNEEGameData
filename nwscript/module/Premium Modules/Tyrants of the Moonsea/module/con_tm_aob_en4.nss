// returns true if the item's existing enchantment is < 4

#include "inc_aob"

int StartingConditional()
{
    int nBonus = AltarGetItemEnhancementBonus();
    return (nBonus < 4);
}
