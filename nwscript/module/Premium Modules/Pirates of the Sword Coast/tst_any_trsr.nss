#include "inc_bootysystem"

void main()
{
    object oTarget = GetFirstPC();
    CreateBootyOnObject(oTarget);
}
