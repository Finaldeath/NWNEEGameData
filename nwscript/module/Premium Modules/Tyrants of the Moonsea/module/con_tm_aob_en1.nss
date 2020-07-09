// returns true if the item's existing enchantment is < 1

#include "inc_aob"

int StartingConditional()
{
    int nBonus = AltarGetItemEnhancementBonus();
    return (nBonus < 1);
}
