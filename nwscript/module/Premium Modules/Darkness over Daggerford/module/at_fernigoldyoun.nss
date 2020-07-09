void main()
{
     object oPC = GetPCSpeaker();
     AssignCommand(GetNearestObjectByTag("pm_fernigold_yng",oPC),SetIsDestroyable(TRUE));
     CreateItemOnObject("a2_pm_fernigold", oPC, 1);
     DestroyObject(GetNearestObjectByTag("pm_fernigold_yng",oPC), 1.0);
     DestroyObject(GetNearestObjectByTag("pm_fernigolddead",oPC), 1.0);
}
