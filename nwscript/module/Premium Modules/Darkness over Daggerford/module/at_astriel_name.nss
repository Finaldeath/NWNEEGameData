// the player knows that amara is astriel

void main()
{
    object oMod = GetModule();
    if (GetLocalInt(oMod, "amara_is_astriel") == 0)
    {
        SetLocalInt(oMod, "amara_is_astriel", 1);
        SetName(OBJECT_SELF, "Astriel Shalyn");
    }
}
