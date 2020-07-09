//::///////////////////////////////////////////////
//:: Act 3: Whirlpool Heartbeat
//:: phb_a3_whirlpool.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Get the whirlpool VFX started.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 27, 2005
//:://////////////////////////////////////////////

void main()
{
    int bDoOnce = GetLocalInt(OBJECT_SELF, "bDoOnce");

    if (bDoOnce == FALSE)
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1000));

        SetLocalInt(OBJECT_SELF, "bDoOnce", TRUE);
    }
}
