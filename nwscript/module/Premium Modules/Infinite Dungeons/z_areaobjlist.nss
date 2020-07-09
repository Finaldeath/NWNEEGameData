// list the name and tag of every object in the area the first pc is in

#include "inc_id1_debug"

void main()
{
    PrintString("");

    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    object oObject = GetFirstObjectInArea(oArea);
    string sName;
    string sTag;
    while (oObject!= OBJECT_INVALID)
    {
        sName = GetName(oObject);
        sTag = GetTag(oObject);
        PrintString("Found object with name " + sName + " and tag " + sTag);

        oObject = GetNextObjectInArea(oArea);
    }

    PrintString("");
}
