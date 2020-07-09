// some areas have more than one enterance, making it hard to place
// encounters so that they get triggered properly. This script links
// two encounter triggers as the same.
//
// 1. Give your linked encounters the same (area unique) tag
// 2. Place this script in the onEnter event for each encounter

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        int i = 1;
        object oMate = GetNearestObjectByTag(GetTag(OBJECT_SELF), oPC, i);
        while (GetIsObjectValid(oMate))
        {
            if (GetObjectType(oMate) == OBJECT_TYPE_ENCOUNTER)
            {
                SetEncounterActive(FALSE, oMate);
            }
            oMate = GetNearestObjectByTag(GetTag(OBJECT_SELF), oPC, ++i);
        }
    }
}
