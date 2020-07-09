// this script summons guards to the area when a fire breaks out

void fightFire(object oGuard, object oFire)
{
    SetLocalInt(oGuard, "nFire", 1);
    AssignCommand(oGuard, ActionMoveToObject(oFire, TRUE, 1.0));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillDecrease(SKILL_LISTEN, 10), oGuard);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillDecrease(SKILL_SPOT, 10), oGuard);
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == 1)
    {
        // an oil barrel has burst into flames
        if (GetLocalInt(OBJECT_SELF, "nGuardsSummoned") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nGuardsSummoned", 1);
            SetLocalInt(OBJECT_SELF, "nGuardsCounter", 5);
            SignalEvent(OBJECT_SELF, EventUserDefined(2));
        }
    }
    else if (nEvent == 2)
    {
        int nCount = GetLocalInt(OBJECT_SELF, "nGuardsCounter");
        if (nCount > 0)
        {
            // display warning message about guards coming
            string sText;
            if (nCount == 5)
                sText = "You hear shouts from upstairs";
            else if (nCount == 4)
                sText = "You hear footsteps on the stairs";
            else if (nCount == 3)
                sText = "You hear shouts outside";
            else
                sText = "Someone is coming";
            object oPC = GetFirstPC();
            if (GetArea(oPC) == OBJECT_SELF)
            {
                FloatingTextStringOnCreature("... " + sText + ":  " + IntToString(nCount) + " ...", oPC);
            }

            // reduce counter
            SetLocalInt(OBJECT_SELF, "nGuardsCounter", --nCount);
            object oSelf = OBJECT_SELF;
            DelayCommand(3.0, SignalEvent(oSelf, EventUserDefined(2)));
        }
        else
        {
            // guards arrive
            object oPC = GetFirstPC();
            SetLocalInt(GetModule(), "nFeldranFire", 1);

            // open the door
            object oDoor = GetObjectByTag("dt_ar2001_fire_door");
            AssignCommand(oDoor, ActionOpenDoor(oDoor));

            // find a fire to move towards
            object oFire = GetObjectByTag("_ar2001_fire");

            // any guards on this level enter
            int i = 1;
            object oGuard = GetNearestObjectByTag("ks_exeltis_guard", oFire, i);
            while (GetIsObjectValid(oGuard))
            {
                fightFire(oGuard, oFire);
                oGuard = GetNearestObjectByTag("ks_exeltis_guard", oFire, ++i);
            }

            // create some guards to run down the hall
            for (i=1; i<=5; i++)
            {
                object oWP = GetWaypointByTag("WP_AR2001_FIRE_GUARD_" + IntToString(i));
                object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_guard", GetLocation(oWP));
                fightFire(oGuard, oFire);
            }
        }
    }
}
