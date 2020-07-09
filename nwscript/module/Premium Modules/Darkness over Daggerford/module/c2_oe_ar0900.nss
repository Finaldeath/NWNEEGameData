#include "hf_in_spawn"

void JumpGnolls(string sTag, string sWP, int nWalk = FALSE);

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // bash a few cave doors
        if (GetLocalInt(OBJECT_SELF, "nDoorAdj") == 0)
        {
            object oDoor = GetObjectByTag("AR0904_AR0900_EXIT");
            effect eDam = EffectDamage(500);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oDoor);

            oDoor = GetObjectByTag("AR0905_AR0900_EXIT");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oDoor);

            //oDoor = GetObjectByTag("AR0900_AR0905_EXIT");
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oDoor);

            SetLocalInt(OBJECT_SELF, "nDoorAdj", 1);
        }

        // if gnolls need to reclaim bridge...
        if (GetLocalInt(OBJECT_SELF, "nGnollsMoved") == 0)
        {
            if (GetLocalInt(GetModule(), "nWH_OgresDispatched") == 1)
            {
                // create a pair of elite to function as gatekeepers
                object oWP = GetObjectByTag("WP_bw_ogre03_ret");
                location lLoc = GetLocation(oWP);
                CreateObject(OBJECT_TYPE_CREATURE, "bw_gnoll05", lLoc, FALSE, "bw_ogre03");
                CreateObject(OBJECT_TYPE_CREATURE, "bw_gnoll05", lLoc, FALSE, "bw_ogre04");

                // move all other gnolls to new points
                JumpGnolls("bw_gnoll01", "ar0900_gnolljp", TRUE);
                JumpGnolls("bw_gnoll02", "ar0900_gnolljp", TRUE);
                JumpGnolls("bw_gnoll05", "ar0903_gnolljp2", FALSE);
                JumpGnolls("bw_gnollking", "ar0903_gnolljp", FALSE);

                object oGnoll = GetObjectByTag("bw_gnoll03");
                DestroyObject(oGnoll);

                oGnoll = GetObjectByTag("bw_gnoll04");
                DestroyObject(oGnoll);

                SetLocalInt(OBJECT_SELF, "nGnollsMoved", 1);
            }
        }

        SpawnEnter(oPC);
    }
}

void JumpGnolls(string sTag, string sWP, int nWalk = FALSE)
{
    // move all other gnolls to new points
    int nNth = 0;
    object oGnoll = GetObjectByTag(sTag, nNth);
    object oJumpPoint = GetObjectByTag(sWP);

    while (GetIsObjectValid(oGnoll))
    {
        AssignCommand(oGnoll, ClearAllActions());
        AssignCommand(oGnoll, JumpToObject(oJumpPoint));
        if (nWalk == TRUE)
        {
            AssignCommand(oGnoll, DelayCommand(5.0f, ActionRandomWalk()));
        }
        nNth += 1;
        oGnoll = GetObjectByTag(sTag, nNth);
    }

    return;
}
