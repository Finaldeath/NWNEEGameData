// returns the first instance of an object with a given tag in a given area
// .. I wrote this function after observing that GetNearestObjectByTag()
// .. sometimes fails when the player object is used in area onEnter scripts
// .. my thinking is that the player isn't fully "inside" the area when
// .. the area's onEnter script executes.

object GetObjectInArea(string sTag, object oPC, int n=1)
{
    object oMyArea = GetArea(oPC);
    int nFound = FALSE;
    int j = 0;
    int i = 0;
    object o = GetObjectByTag(sTag, i);
    while (GetIsObjectValid(o))
    {
        if (GetArea(o) == oMyArea)
        {
            if (++j == n)
            {
                nFound = TRUE;
                break;
            }
        }
        o = GetObjectByTag(sTag, ++i);
    }
    if (nFound == TRUE)
        return(o);
    return(OBJECT_INVALID);
}

