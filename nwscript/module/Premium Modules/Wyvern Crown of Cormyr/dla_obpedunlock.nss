void main()
{
    object oPC =     GetLastUsedBy();
    if (GetLocalInt(oPC,"nKeysOn")==3) SetLocked(OBJECT_SELF,FALSE);
}
