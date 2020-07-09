// player makes taffy angry
// .. he attacks and the mariners do too

void GoHostile(object oNPC, object oPC)
{
    if (GetIsObjectValid(oNPC))
    {
        SetIsTemporaryEnemy(oNPC, oPC);
        SetIsTemporaryEnemy(oPC, oNPC);
        AssignCommand(oNPC, ActionEquipMostDamagingMelee(oPC));
        AssignCommand(oNPC, ActionAttack(oPC));
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    SetLocalInt(oArea, "nMarinersAttacked", 1);
    object oTaffy = GetNearestObjectByTag("pm_marinerguard", oPC);
    GoHostile(oTaffy, oPC);
    object oMariner1 = GetNearestObjectByTag("pm_mariner1", oPC);
    GoHostile(oMariner1, oPC);
    object oMariner2 = GetNearestObjectByTag("pm_mariner2", oPC);
    GoHostile(oMariner2, oPC);
}
