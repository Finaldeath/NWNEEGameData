// goblin AI uses user-defined events

#include "x2_inc_switches"
#include "x0_i0_anims"
#include "x0_i0_treasure"

void main()
{
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    SetCombatCondition(X0_COMBAT_FLAG_RANGED);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
