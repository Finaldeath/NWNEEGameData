// area enter script for mulmaster imperial district

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
        }
    }
}
