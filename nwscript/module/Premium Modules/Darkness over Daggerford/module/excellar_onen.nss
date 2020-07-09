void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        object oMap = GetItemPossessedBy(oPC, "ks_olree_map");
        if(GetIsObjectValid(oMap))
        {
            DestroyObject(oMap);
        }
    }
}
