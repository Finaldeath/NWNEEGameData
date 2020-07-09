// secret: marks location of imprisoned solar in thar scar lands

void main()
{
    object oWP = GetWaypointByTag("WP_TH_SCL_SOLAR");
    if (GetIsObjectValid(oWP))
    {
        SetMapPinEnabled(oWP, TRUE);
    }
}
