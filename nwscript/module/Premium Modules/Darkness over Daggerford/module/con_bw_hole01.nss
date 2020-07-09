void main()
{
    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(GetPCSpeaker(), sItem);

    DestroyObject(oItem, 0.3f);

    object oWP = GetNearestObjectByTag("wp_ar0800_rope");
    location lWP = GetLocation(oWP);

    CreateObject(OBJECT_TYPE_PLACEABLE, "pdag_ropecrvl1", lWP);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
