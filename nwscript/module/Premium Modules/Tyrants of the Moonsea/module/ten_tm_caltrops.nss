//Launch caltrops at PC in Kur-Tharsu Main Gate area
void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        object oCaltrops = GetNearestObjectByTag("CaltropsLauncher");

        AssignCommand(oCaltrops,
            ActionCastSpellAtObject(SPELL_GRENADE_CALTROPS, oPC,
                                    METAMAGIC_ANY, TRUE, 0,
                                    PROJECTILE_PATH_TYPE_BALLISTIC));
    }
}
