//::///////////////////////////////////////////////
//:: cex_vantab_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vantabular goes to the Monkey's Cutless
    after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oVantab = OBJECT_SELF;
    int iExit = GetLocalInt(oVantab, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        object oDoor = GetObjectByTag("");
        object oWPCutless = GetWaypointByTag("WP_VANTAB_HOME");

        location lCutless = GetLocation(oWPCutless);
        location lVantab = GetLocation(oVantab);

        effect ePoof1 = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
        effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

        SetLocalInt(oVantab, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oVantab, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oVantab, 10.0f);
        ChangeToStandardFaction(oVantab, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oVantab, TRUE);

        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, ePoof1, lVantab, 3.0f);
        AssignCommand(oModule, DelayCommand(1.5f,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lVantab)));

        AssignCommand(oModule, DelayCommand(1.4f,
            SetLocalInt(oVantab, "NO_TALKIE", FALSE)));
        AssignCommand(oModule, DelayCommand(1.5f,
            AssignCommand(oVantab, JumpToLocation(lCutless))));
    }

    //JE: Also need scripting for when Vantabular goes into the
    //lighthouse from the beach
    if (GetLocalInt(OBJECT_SELF, "EXIT_TO_LIGHTHOUSE"))
    {
        //RB: He should only do this if he's in the Sandy Spit, however.
        object oArea = GetArea(OBJECT_SELF);
        string sArea = GetTag(oArea);
        object oDoor = GetObjectByTag("a2_spit_lighthouse");
        //if (sArea == "spindriftsndspt") // that's not the tag, that's the resref
        if(sArea == "CoastalIsland")
        {
            SetLocalInt(OBJECT_SELF, "EXIT_TO_LIGHTHOUSE", FALSE);
            SetLocalInt(OBJECT_SELF, "NO_TALKIE", TRUE);

            // assign command to the area, just in case V. gets destroyed before
            // executing the delay command
            AssignCommand(oArea, DelayCommand(3.0, SetWeather(oArea, WEATHER_RAIN)));

            ActionOpenDoor(oDoor);
            ActionWait(0.8);
            // assign command to the door, since V. is getting destroyed
            ActionDoCommand(AssignCommand(oDoor, DelayCommand(1.0, ActionCloseDoor(oDoor))));
            ActionDoCommand(DestroyObject(OBJECT_SELF, 0.1));

            // failsafe to ensure he really does get destroyed
            DestroyObject(OBJECT_SELF, 30.0);
        }
        else
        {
            // JE: EXIT_TO_LIGHTHOUSE can only be set on the first time
            // talking to Vantabular, and this should be all but impossible
            // to have happen outside of the Sandy Spit area - unless you're
            // cheating... but if it does happen it would mean there is a
            // Vantabular still outside in the Sandy Spit area that shouldn't
            // be there. So we should destroy him.
            object oVantab = GetObjectByTagInArea("a2_vantabular", GetObjectByTag("CoastalIsland"));
            DestroyObject(oVantab);
        }
    }
}
