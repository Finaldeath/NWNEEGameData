// returns true when the altar is empty

#include "inc_aob"

int StartingConditional()
{
    int nCount = AltarGetItemCount();
    return (nCount == 0);
}
