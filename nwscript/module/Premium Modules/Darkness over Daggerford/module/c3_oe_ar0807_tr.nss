// signals event for area to give journal update
// when red portal is destroyed
// (double check)
// -bw

void main()
{
    object oArea = GetArea(OBJECT_SELF);

    if (GetLocalInt(oArea, "nTriggered") == 2)
    {
        if (GetLocalInt(oArea, "nPortalDestroyed") == 0)
        {
            object oPortal = GetNearestObjectByTag("bw_ar0807_pred");

            if (!GetIsObjectValid(oPortal))
            {
                SignalEvent(oArea, EventUserDefined(503)); // portal destroyed
            }
        }
    }
}
