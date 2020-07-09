void main()
{
    SetLocalInt(GetModule(), "iBargeQuestGiven", 1);
    CreateItemOnObject("ac_harborbottom", GetPCSpeaker());
    CreateItemOnObject("ac_taintedharbor", GetPCSpeaker());
}
