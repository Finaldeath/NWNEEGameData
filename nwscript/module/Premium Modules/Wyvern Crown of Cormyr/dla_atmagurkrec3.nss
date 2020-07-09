// February 2006
// B W-Husey
// Controls Magurk's tall stories. Records the last tall story told.

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"nTallStory",3);
    SetLocalInt(oPC,"nTallDay", GetCalendarDay());
}
