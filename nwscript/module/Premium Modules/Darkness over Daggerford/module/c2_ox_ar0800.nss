// make sure mags and her skiff are removed when PC exits the area
// .. need to do this in case the player exits without speaking to Mags

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        object oMagdaren = GetNearestObjectByTag("db_magdaren", oPC);
        if (GetIsObjectValid(oMagdaren))
        {
            DestroyObject(oMagdaren);
        }
        object oSkiff = GetNearestObjectByTag("db_skiff", oPC);
        if (GetIsObjectValid(oSkiff))
        {
            DestroyObject(oSkiff);
        }
    }
}
