#include "dla_i0_joust"

int StartingConditional()
{
    return !DLA_JoustGetIsEquipped(GetPCSpeaker());
}
