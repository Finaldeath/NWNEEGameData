// the butcher grabs the chicken

void main()
{
    object oPC = GetPCSpeaker();
    object oChicken = GetNearestObjectByTag("ks_druid_chick", oPC);
    PlaySound("c_chicken_bat1");
    SetFacingPoint(GetPosition(oChicken));
    PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0);
    DestroyObject(oChicken, 1.0);
    AddJournalQuestEntry("j86", 10, oPC);
}
