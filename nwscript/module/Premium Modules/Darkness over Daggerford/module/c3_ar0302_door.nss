// when the player opens the basement door in the mariner's alliance (AR0302)
// .. any mariners (and taffy) in the area go hostile and attack
// .. (if taffy is still around and not unconcious)

void GoHostile(object oNPC, object oPC)
{
    SetIsTemporaryEnemy(oNPC, oPC);
    SetIsTemporaryEnemy(oPC, oNPC);
    AssignCommand(oNPC, ActionEquipMostDamagingMelee(oPC));
    AssignCommand(oNPC, ActionAttack(oPC));
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetFirstPC();

    if (GetArea(oPC) == oArea)
    {
        if (GetLocalInt(oArea, "nMarinersAttacked") == 0)
        {
            SetLocalInt(oArea, "nMarinersAttacked", 1);
            object oTaffy = GetNearestObjectByTag("pm_marinerguard", OBJECT_SELF);
            if (GetIsObjectValid(oTaffy))
            {
                if (GetLocalInt(oTaffy, "nSleepy") == 0 &&
                    GetLocalInt(oTaffy, "ac_taffy_opendoor") == 0)
                {
                    GoHostile(oTaffy, oPC);
                    object oMariner1 = GetNearestObjectByTag("pm_mariner1", OBJECT_SELF);
                    GoHostile(oMariner1, oPC);
                    object oMariner2 = GetNearestObjectByTag("pm_mariner2", OBJECT_SELF);
                    GoHostile(oMariner2, oPC);
                }
            }
        }
    }
}
