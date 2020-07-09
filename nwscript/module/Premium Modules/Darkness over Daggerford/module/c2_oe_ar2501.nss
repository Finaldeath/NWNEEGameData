// onEnter event for AR2501 (Illefarn)
// .. veiti will rejoin the player after returning

#include "hf_in_spawn"
#include "hf_in_util"
#include "hf_in_henchman"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // run the standard spawns
        SpawnEnter(oPC);

        // veiti rejoins the player
        if (GetLocalInt(oPC, "VEITI_REJOIN") != 0)
        {
            SetLocalInt(oPC, "VEITI_REJOIN", 0);
            object oVeiti = GetObjectInArea("db_veiti", OBJECT_SELF);
            if (GetIsObjectValid(oVeiti))
            {
                if (!HenchmanIsMine(oVeiti, oPC))
                {
                    HenchmanHire(oVeiti, oPC);
                }
            }
        }
    }
}
