void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"pm_fernigolddead", 1)  ;
    CreateItemOnObject("a2_pm_fernigold", oPC);
}
