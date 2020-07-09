// player has used one of the pillars of fire in the tower puzzle room
// .. this turns on the pillar. when all four pillars are lit, the ice
// .. crystal starts to melt. the ice mephits don't like this and will
// .. turn the pillar off again.

void main()
{
    object oPC = GetLastUsedBy();
    object oArea = GetArea(oPC);

    if (GetLocalInt(OBJECT_SELF, "nOnOff") == 0)
    {
        if (GetIsPC(oPC))
        {
            // the pillar is off, turn it on (only players can do this)
            SetLocalInt(OBJECT_SELF, "nOnOff", 1);
            int nPillarsOn = GetLocalInt(oArea, "nPillarsOn");
            SetLocalInt(oArea, "nPillarsOn", ++nPillarsOn);
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            PlaySound("sim_exp2flame");
            SpeakString("You kindle the fire.");

            // the nearest mephit will try to turn it off
            object oMephit = GetNearestObjectByTag("ks_mephit_ice", oPC);
            if (GetIsObjectValid(oMephit))
            {
                SignalEvent(oMephit, EventUserDefined(1));
            }

            // if all four pillars are on, start melting the crystal
            if (nPillarsOn >= 4)
            {
                object oFlame = GetNearestObjectByTag("_ar1106_fire", oPC);
                if (!GetIsObjectValid(oFlame))
                {
                    object oCrystal = GetNearestObjectByTag("ks_pl_icecrystal", oPC);
                    location lLoc = GetLocation(oCrystal);
                    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lLoc, FALSE, "_ar1106_fire");
                    AssignCommand(oCrystal, ActionSpeakString("... the crystal is melting ..."));
                }
            }
        }
    }
    else
    {
        // pillar is on, so turn it off
        SetLocalInt(OBJECT_SELF, "nOnOff", 0);
        int nPillarsOn = GetLocalInt(oArea, "nPillarsOn");
        SetLocalInt(oArea, "nPillarsOn", --nPillarsOn);
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        if (GetIsPC(oPC))
        {
            SpeakString("You smother the fire.");
        }
        else
        {
            SpeakString("The mephit smothers the fire!");
        }

        // stop melting the crystal when all four pillars are off (and fire portal not appeared yet)
        object oFlame = GetNearestObjectByTag("ks_pl_devflame", oPC);
        if (!GetIsObjectValid(oFlame))
        {
            object oFire = GetNearestObjectByTag("_ar1106_fire", oPC);
            if (GetIsObjectValid(oFire))
            {
                DestroyObject(oFire);
                object oCrystal = GetNearestObjectByTag("ks_pl_icecrystal", oPC);
                AssignCommand(oCrystal, ActionSpeakString("... the crystal has stopped melting ..."));
            }
        }
    }
}
