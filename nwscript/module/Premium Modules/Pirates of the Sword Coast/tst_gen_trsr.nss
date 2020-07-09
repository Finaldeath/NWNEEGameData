#include "inc_bootysystem"

void main()
{
    object oTarget = GetFirstPC();
    CreateBootyOnObject(oTarget, BOOTY_GENERIC);
}
