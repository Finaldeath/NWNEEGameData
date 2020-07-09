// the mariner's guards flee the ship, leaving behind a key

void createkey(object oPC)
{
    AssignCommand(oPC, PlaySound("it_key"));
    CreateObject(OBJECT_TYPE_ITEM, "pm_keyar0501", GetLocation(GetObjectByTag("pm_barracudakeydrop")));
}

void flee(object oNPC)
{
    // remove they key we are going to drop
    object oKey = GetItemPossessedBy(oNPC, "pm_keyar0501");
    if (GetIsObjectValid(oKey))
        DestroyObject(oKey);

    // run away!
    SetLocalString(oNPC, "HF_EXIT_NAME", "WP_AR0400_BARRACUDA_FLEE");
    SetLocalInt(oNPC, "HF_EXIT_RUN", 1);
    SetLocalInt(oNPC, "HF_EXIT_MAX_DELAY", 8);
    ExecuteScript("hf_cs_exit", oNPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oCrew1 = GetNearestObjectByTag("pm_barracudacrew", oPC);
    object oCrew2 = GetNearestObjectByTag("pm_barracudacre2", oPC);
    flee(oCrew1);
    flee(oCrew2);
    DelayCommand(2.0, createkey(oPC));
    DelayCommand(2.2, FloatingTextStringOnCreature("The half orc drops something as he flees!", oPC));
}
