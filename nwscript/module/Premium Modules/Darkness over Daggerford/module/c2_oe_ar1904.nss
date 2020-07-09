// player has entered the crafter's hut
// play leaky water sound effect if 1 to 4 guords are punctured

#include "hf_in_spawn"
#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        int nLeaks = GetLocalInt(OBJECT_SELF, "nLeakyGuords");
        if (nLeaks <= 0 || nLeaks >= 4)
        {
            object oSnd = GetObjectInArea("ks_snd_guordleak", OBJECT_SELF);
            SoundObjectStop(oSnd);
        }
        SpawnEnter(oPC);
    }

    // apply watery footsteps if there's water in here
    if (GetLocalInt(OBJECT_SELF, "nWater") != 0)
    {
        if (GetFootstepType(oPC) == FOOTSTEP_TYPE_LARGE)
        {
            SetFootstepType(16, oPC);
        }
        else
        {
            SetFootstepType(15, oPC);
        }
    }
}
