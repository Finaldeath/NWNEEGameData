// is this creature mute?

#include "nw_i0_generic"

int StartingConditional()
{
    return(GetHasEffect(EFFECT_TYPE_SILENCE, OBJECT_SELF));
}
