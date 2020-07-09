// B W-Husey
// November 2004
// Spawns in dead


#include "x2_inc_switches"
void main()
{

    // Execute default OnSpawn script.
//    ExecuteScript("nw_c2_default9", OBJECT_SELF);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,FALSE),OBJECT_SELF);
}
