//::///////////////////////////////////////////////
//::
//:: a3_od_bw_place
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Death script for placeables.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

void main()
{
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "bw_blocker")
    {
        object oBlocked = GetNearestObjectByTag("bw_blocked");

        if (GetIsObjectValid(oBlocked))
        {
            if (GetLocked(oBlocked))
            {
                // this door might be blocked
                int nNth = 1;
                object oBlocker = GetNearestObjectByTag("bw_blocker", oBlocked, nNth);
                int nBlocked = 0;
                float fDist = GetDistanceBetween(oBlocked, oBlocker);

                while (GetIsObjectValid(oBlocker) && (nBlocked == 0))
                {
                    if ((fDist < 6.0f) && (fDist >= -0.0f))
                    {
                        if ((GetCurrentHitPoints(oBlocker) > 0)
                         && (oBlocked != OBJECT_SELF))
                        {
                            nBlocked = 1;
                        }
                    }
                    nNth += 1;
                    oBlocker = GetNearestObjectByTag("bw_blocker", oBlocked, nNth);
                    fDist = GetDistanceBetween(oBlocked, oBlocker);
                }

                if (nBlocked == 0)
                {
                    SetLocked(oBlocked, FALSE);
                }
            }
        }
    }
    else if (sTag == "bw_sarcoph")
    {
        SetLocalInt(GetModule(), "nIH_RobbedTomb", 1);
    }
}
