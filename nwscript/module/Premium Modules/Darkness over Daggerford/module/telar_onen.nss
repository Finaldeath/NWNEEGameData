void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        object oMap = GetItemPossessedBy(oPC, "pm_fernigoldmap");
        if(GetIsObjectValid(oMap))
        {
            DestroyObject(oMap);
        }
    }
}
