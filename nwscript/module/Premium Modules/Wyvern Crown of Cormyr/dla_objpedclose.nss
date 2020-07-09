#include "x0_i0_petrify"

void main()
{
    SetLocked(OBJECT_SELF,TRUE);
    RemoveEffectOfType(OBJECT_SELF,EFFECT_TYPE_BEAM);
}
