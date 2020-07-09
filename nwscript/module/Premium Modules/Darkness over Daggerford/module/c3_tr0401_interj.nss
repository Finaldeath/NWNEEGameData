// this interjection only makes sense if the girl selling golden books is nearby

void main()
{
    object oGirl = GetNearestObjectByTag("ks_golden_girl", OBJECT_SELF);
    if (GetIsObjectValid(oGirl))
    {
        ExecuteScript("hf_tu_henchman", OBJECT_SELF);
    }
}
