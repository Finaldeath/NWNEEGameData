// returns true when the altar contains more than one item

#include "inc_aob"

int StartingConditional()
{
    int nCount = AltarGetItemCount();
    return (nCount > 1);
}
