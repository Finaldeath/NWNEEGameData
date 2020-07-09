// returns true when the beggar has enough coins to go drinking!

#include "hf_in_plot"

int StartingConditional()
{
    int nTotalCoins = GetLocalInt(OBJECT_SELF, "nTotalCoins");
    return (nTotalCoins >= 3);
}
