void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && (GetLocalInt(oPC, "ac_wildelves_quest") == 3) &&
       GetLocalInt(OBJECT_SELF, "iActivated") == 0)
    {
        int i = 1;
        SetLocalInt(OBJECT_SELF, "iActivated", 1);
        SetLocalInt(GetModule(), "iKyleenaDeparted", 1);

        object oLeaver = GetObjectByTag("ac_kyleena");
        ExecuteScript("hf_cs_exit", oLeaver);
        oLeaver = GetObjectByTag("ac_wildelfguard");
        ExecuteScript("hf_cs_exit", oLeaver);
        oLeaver = GetNearestObjectByTag("ac_wildelfguard2", oPC, i);

        while(GetIsObjectValid(oLeaver))
        {
            ExecuteScript("hf_cs_exit", oLeaver);
            i++;
            oLeaver = GetNearestObjectByTag("ac_wildelfguard2", oPC, i);
        }

        DestroyObject(GetNearestObjectByTag("WildElfTent1", oPC));
        DestroyObject(GetNearestObjectByTag("WildElfTent2", oPC));
        AssignCommand(GetNearestObjectByTag("WildElfCampfire", oPC),
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}
