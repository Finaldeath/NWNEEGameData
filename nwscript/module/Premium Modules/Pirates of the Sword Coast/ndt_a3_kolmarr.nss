//::///////////////////////////////////////////////
//:: ndt_a3_kolmarr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Kolmarrs Cutstom death script.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_undead"

void HandleEscape();
void CreateCrewman();
void ForceJumpToLocation(object oObject, location lTarget);
void RemoveDarkness(object oTarget);

void main()
{
    object oModule = GetModule();
    object oArea = GetArea(OBJECT_SELF);
    object oGate = GetObjectByTag("a3_deaddoor");
    int iDoOnce = GetLocalInt(oModule, "ndt_a3_kolmarr");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "ndt_a3_kolmarr", TRUE);
        SetLocalInt(oGate, "OPEN_GATE", FALSE);

        // clear out any AOEs before everyone leaves.
        object oAOE = GetFirstObjectInArea(oArea);
        while(GetIsObjectValid(oAOE))
        {
            if(GetObjectType(oAOE)==OBJECT_TYPE_AREA_OF_EFFECT)
            {
                DestroyObject(oAOE, 0.2);
            }

            oAOE = GetNextObjectInArea(oArea);
        }

        // teleport everyone out of the Seplture and onto the hill
        // (The crew and Henchmen should go too)
        AssignCommand(oModule, HandleEscape());
    }
}

void RemoveDarkness(object oTarget)
{
    effect eCursor = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eCursor) == TRUE)
    {
        // Remove any lingering Darkness
        if (GetEffectType(eCursor) == EFFECT_TYPE_DARKNESS)
        {
            DelayCommand(0.1f, RemoveEffect(oTarget, eCursor));
        }

        eCursor = GetNextEffect(oTarget);
    }
}

void Debug(string sMSG)
{
    /*object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC) == TRUE)
    {
        //SendMessageToPC(oPC, sMSG);
        oPC = GetNextPC();
    }*/
}

void CreateCrewman()
{
    object oModule = GetModule();
    object oWayPoint;
    object oCrew;

    string sCrew;
    location lTarg;
    int iCounter = 1;

    while (iCounter < 6)
    {
        sCrew = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
        oWayPoint = GetWaypointByTag("WPA3_FOLLOW_CI_0" + IntToString(iCounter));
        lTarg = GetLocation(oWayPoint);

        // create them and prevent this iteration of henchmen for ever dieing
        oCrew = CreateObject(OBJECT_TYPE_CREATURE, sCrew, lTarg);
        SetImmortal(oCrew, TRUE);

        //Debug("Creating object '" + GetTag(oCrew) + "' at object '"+GetTag(oWayPoint)+"'");
        iCounter++;
    }
}

void ForceJumpToLocation(object oObject, location lTarget)
{
    location lObject = GetLocation(oObject);

    if (GetAreaFromLocation(lObject) != GetAreaFromLocation(lTarget))
    {
        AssignCommand(oObject, JumpToLocation(lTarget));
        DelayCommand(0.5f, ForceJumpToLocation(oObject, lTarget));
    }
}

void HandleEscape()
{
    object oPC = OBJECT_INVALID;
    object oModule = OBJECT_SELF;
    object oNPCJump, oNPC, oJump, oTom;

    object oGarm = GetObjectByTag("a1_hench_garm");
    object oNisar = GetObjectByTag("a2_hench_nisar");

    location lTarg;
    effect eVFX = EffectVisualEffect(VFX_IMP_DEATH_L);
    effect eRes = EffectResurrection();
    string sMonster = "NECRO_MONSTER";
    int iCounter = 1;

    // update old tom
    oTom = GetObjectByTag("a3_oldtom_a");
    lTarg = GetLocation(oTom);
    DestroyObject(oTom);
    oTom = CreateObject(OBJECT_TYPE_CREATURE, "a3_oldtom_b", lTarg);

    // surrender then destroy the hostiles.
    while (iCounter < 6)
    {
        sMonster = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
        oNPC = GetObjectByTag(sMonster);
        DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oNPC));
        DelayCommand(1.1f, ChangeToStandardFaction(oNPC, STANDARD_FACTION_DEFENDER));
        DelayCommand(1.3f, AssignCommand(oNPC, SurrenderToEnemies()));

//        Debug("Surrendering object '" + GetTag(oNPC) + "'");
        DelayCommand(2.0f, AssignCommand(oNPC, SetIsDestroyable(TRUE, FALSE, FALSE)));
        DelayCommand(2.5f, DestroyObject(oNPC));

        iCounter++;
    }

    // Send the PC to the surface
    oPC = GetFirstPC();
    oJump = GetWaypointByTag("A3_PC_AFTERDEAD");
    lTarg = GetLocation(oJump);
    while (GetIsObjectValid(oPC) == TRUE)
    {
        //Debug("Teleporting player object '" + GetName(oPC) + "'");

        DelayCommand(1.0f, FadeToBlack(oPC, FADE_SPEED_MEDIUM));
        DelayCommand(1.5f, RemoveDarkness(oPC));
        DelayCommand(2.5f, ForceJumpToLocation(oPC, lTarg));
        DelayCommand(2.6f, StopFade(oPC));

        oPC = GetNextPC();
    }

    DelayCommand(2.0f, ExecuteScript("exe_a3_dead50", GetFirstPC()));

    // reset Garm and Nisar's VFX Eyes

    // Jump the henchmen to the correct area.
//    Debug("Jumping Nisar = '" +GetTag(oNisar)+ "' int area = '" +GetTag(GetArea(oNisar))+ "'");
    DelayCommand(2.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eRes, oNisar));
    DelayCommand(2.1f, ApplyVFXEyes(oNisar));
    DelayCommand(2.2f, AssignCommand(oNisar, ClearAllActions(TRUE)));
    DelayCommand(2.5f, AssignCommand(oNisar, JumpToLocation(lTarg)));

//    Debug("Jumping Garm = '" +GetTag(oGarm)+ "' int area = '" +GetTag(GetArea(oGarm))+ "'");
    DelayCommand(2.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eRes, oGarm));
    DelayCommand(2.1f, ApplyVFXEyes(oGarm));
    DelayCommand(2.2f, AssignCommand(oGarm, ClearAllActions(TRUE)));
    DelayCommand(2.5f, AssignCommand(oGarm, JumpToLocation(lTarg)));

    //Create Crewmen on the surface
    CreateCrewman();
}

