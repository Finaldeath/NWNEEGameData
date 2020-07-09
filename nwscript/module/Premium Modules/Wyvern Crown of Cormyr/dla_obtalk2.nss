// January 2006
// B W-Husey
// Generic OnUsed script for objects that float their name.
void main()
{
    object oPC = GetLastUsedBy();
    FloatingTextStringOnCreature(GetName(OBJECT_SELF),oPC,FALSE);
}
