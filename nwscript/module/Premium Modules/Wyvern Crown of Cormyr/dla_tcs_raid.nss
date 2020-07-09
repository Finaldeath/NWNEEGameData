#include "dla_i0_csintro"
#include "cu_functions"

void RemoveCutsceneEffects(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENEGHOST)
        {
            RemoveEffect(oPC, eEffect);
            return;
        }
        eEffect = GetNextEffect(oPC);
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsDefPC(oPC)) return;
    object oArea = GetArea(oPC);
    // Sets time to 5:30pm .. the module minutes/hour is set to 5 .. which means
    // 5 realtime minutes = 1 game time hour.  The clock rolls the game hour every
    // 5 minutes .. so .. setting time to 17,2,30,0  (Hour, Min, Sec, Milsec)
    // is the same as 5:30pm game time.
//    SetTime(17,2,30,0);

    object oFather = GetObjectByTag(CS_Father);
    object oLena = GetObjectByTag(CS_Lena);
    int nAppType = APPEARANCE_TYPE_HUMAN;
    switch (GetRacialType(oPC))
    {
        case RACIAL_TYPE_DWARF:    nAppType = APPEARANCE_TYPE_DWARF;    break;
        case RACIAL_TYPE_HALFLING: nAppType = APPEARANCE_TYPE_HALFLING; break;
        case RACIAL_TYPE_GNOME:    nAppType = APPEARANCE_TYPE_GNOME;    break;
        case RACIAL_TYPE_HALFORC:  nAppType = APPEARANCE_TYPE_HALF_ORC; break;
    }
    SetCreatureAppearanceType(oFather, nAppType);
    SetCreatureAppearanceType(oLena, nAppType);

    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eGhost = EffectCutsceneGhost();
    effect eLink = EffectLinkEffects(eInvis, eGhost);

    AmbientSoundPlay(GetArea(OBJECT_SELF));

    switch (GetLocalInt(oArea, "dla_tcs_raid"))
    {
        case 0: //Scene 1
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC);
            SetLocalInt(oArea, "dla_tcs_raid", 1);

            // Actors
            object oLena  = GetObjectByTag(CS_Lena);
            object oMaria = GetObjectByTag(CS_Maria);

            // Stage Movements
            object oWPMaria = GetWaypointByTag(CS_WPMaria01);
            object oWPLena  = GetWaypointByTag(CS_WPLena01);

            // Camera
            StartCutscene(oPC, 350.0, 3.0, 75.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand( 6.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand( 6.8, EndCutscene(0.0, 15.0, 50.0, SNAP));
            DelayCommand( 7.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera2)))));

            // Action
            DelayCommand( 0.1, AssignCommand(oMaria, ActionMoveToObject(oWPMaria, FALSE, 0.0)));
            DelayCommand( 0.5, AssignCommand(oLena, ActionMoveToObject(oWPLena, FALSE, 0.0)));
            DelayCommand( 1.5, AssignCommand(oLena, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0)));
            DelayCommand( 3.0, AssignCommand(oLena, SpeakString(sLineLena1)));
            DelayCommand( 3.5, AssignCommand(oMaria, SpeakString(sLineMaria1)));
        }; break;
        case 1: // Scene 2
        {
            SetLocalInt(oArea, "dla_tcs_raid", 2);

            // Actors
            object oHG4 = GetObjectByTag(CS_HG4);
            object oHG5 = GetObjectByTag(CS_HG5);
            object oHG6 = GetObjectByTag(CS_HG6);

            // Stage Movements
            object oWPHG4 = GetWaypointByTag(CS_WPHG401);
            object oWPHG5 = GetWaypointByTag(CS_WPHG501);
            object oWPHG6 = GetWaypointByTag(CS_WPHG601);

            // Camera
            StartCutscene(oPC, 335.0, 1.0, 80.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand( 2.1, Pan(355.0, 1.0, 80.0, VERY_SLOW));
            DelayCommand( 7.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand( 7.8, EndCutscene());
            DelayCommand( 8.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera3)))));

            // Action
            DelayCommand( 0.5, AssignCommand(oHG6, ActionMoveToObject(oWPHG6, TRUE)));
            DelayCommand( 1.5, AssignCommand(oHG4, ActionMoveToObject(oWPHG4, TRUE)));
            DelayCommand( 3.5, AssignCommand(oHG5, ActionMoveToObject(oWPHG5, TRUE)));
            DelayCommand( 5.0, SignalEvent(oHG5, EventUserDefined(CS_INTRO_KILLCHICKEN)));
            DelayCommand( 7.5, AssignCommand(oHG5, ActionMoveToObject(oWPHG5, TRUE)));
        }; break;
        case 2: // Scene 3
        {
            SetLocalInt(oArea, "dla_tcs_raid", 3);

            // Actors
            object oFather = GetObjectByTag(CS_Father);
            object oDog    = GetObjectByTag(CS_Dog);

            // Stage Movements
            object oWalk = GetWaypointByTag(CS_WPFather02);

            // Camera
            StartCutscene(oPC, 315.0, 3.0, 80.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand( 7.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand( 7.8, EndCutscene());
            DelayCommand( 8.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera4)))));

            // Action
            DelayCommand( 1.0, AssignCommand(oFather, ActionCloseDoor(GetObjectByTag("CS_CowDoor"))));
            DelayCommand( 1.5, AssignCommand(oFather, SpeakString(sLineFather1)));
            DelayCommand( 2.0, AssignCommand(oDog, ActionMoveToObject(oWalk)));
            DelayCommand( 3.0, AssignCommand(oFather, ActionMoveToObject(oWalk)));
        }; break;
        case 3: // Scene 4
        {
            SetLocalInt(oArea, "dla_tcs_raid", 4);

            // Actors
            object oHG1 = GetObjectByTag(CS_HG1);
            object oHG2 = GetObjectByTag(CS_HG2);
            object oHG3 = GetObjectByTag(CS_HG3);

            // Stage movements
            object oWPHG1 = GetWaypointByTag(CS_WPHG101);
            object oWPHG2 = GetWaypointByTag(CS_WPHG201);
            object oWPHG3 = GetWaypointByTag(CS_WPHG301);

            // Camera
            StartCutscene(oPC, 55.0, 1.0, 80.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand( 3.1, Pan(125.0, 4.0, 70.0, MEDIUM));
            DelayCommand( 5.1, Pan(225.0, 10.0, 55.0, MEDIUM));
            DelayCommand( 9.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand( 9.8, EndCutscene());
            DelayCommand(10.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera1)))));

            // Action
            DelayCommand( 0.5, AssignCommand(oHG3, ActionMoveToObject(oWPHG3, TRUE)));
            DelayCommand( 1.5, AssignCommand(oHG2, ActionMoveToObject(oWPHG2, TRUE)));
            DelayCommand( 3.5, AssignCommand(oHG1, ActionMoveToObject(oWPHG1, TRUE)));
        }; break;
        case 4: // Scene 5
        {
            SetLocalInt(oArea, "dla_tcs_raid", 5);

            // Actors
            object oLena  = GetObjectByTag(CS_Lena);
            object oMaria = GetObjectByTag(CS_Maria);
            object oDalan = GetObjectByTag(CS_Dalan);

            // Stage Movements
            object oWPDalan = GetWaypointByTag(CS_WPDalan01);

            // Props
            object oDoor = GetObjectByTag(CS_DoorCormas);

            // Camera
            StartCutscene(oPC, 350.0, 3.0, 75.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand(30.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand(30.8, EndCutscene(0.0, 15.0, 50.0, SNAP));
            DelayCommand(31.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera5)))));

            // Actions
            DelayCommand( 1.5, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
            DelayCommand( 4.5, AssignCommand(oDalan, JumpToObject(oWPDalan)));
            DelayCommand( 5.0, AssignCommand(oDalan, SpeakString(sLineDalan1)));
            DelayCommand( 6.0, AssignCommand(oMaria, SpeakString(sLineMaria2)));
            DelayCommand( 9.5, AssignCommand(oLena, SpeakString(sLineLena2)));
            DelayCommand(13.5, AssignCommand(oDalan, SpeakString(sLineDalan2)));
            DelayCommand(17.5, AssignCommand(oLena, SpeakString(sLineLena3)));
            DelayCommand(21.0, AssignCommand(oMaria, SpeakString(sLineMaria3)));
            DelayCommand(25.0, AssignCommand(oDalan, SpeakString(sLineDalan3)));
        }; break;
        case 5: // Scene 6
        {
            SetLocalInt(oArea, "dla_tcs_raid", 6);

            // Actors
            object oHG4 = GetObjectByTag(CS_HG4);
            object oHG5 = GetObjectByTag(CS_HG5);
            object oHG6 = GetObjectByTag(CS_HG6);

            // Stage movements
            object oWPHG4 = GetWaypointByTag(CS_WPHG402);
            object oWPHG5 = GetWaypointByTag(CS_WPHG502);
            object oWPHG6 = GetWaypointByTag(CS_WPHG602);

            // Camera
            StartCutscene(oPC, 310.0, 3.0, 80.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand( 7.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand( 7.9, EndCutscene());
            DelayCommand( 8.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(CS_Camera1)))));

            // Action
            DelayCommand( 0.5, AssignCommand(oHG4, ActionMoveToObject(oWPHG4, TRUE)));
            DelayCommand( 1.0, AssignCommand(oHG6, ActionMoveToObject(oWPHG6, TRUE)));
            DelayCommand( 3.5, AssignCommand(oHG5, ActionMoveToObject(oWPHG5, TRUE)));
            DelayCommand( 7.5, AssignCommand(oHG4, ClearAllActions()));
            DelayCommand( 7.6, AssignCommand(oHG5, ClearAllActions()));
            DelayCommand( 7.7, AssignCommand(oHG4, JumpToObject(GetWaypointByTag(CS_WPHG401))));
            DelayCommand( 7.8, AssignCommand(oHG5, JumpToObject(GetWaypointByTag(CS_WPHG503))));
        }; break;
        case 6: // Scene 7
        {
            SetLocalInt(oArea, "dla_tcs_raid", 7);

            // Actors
            object oLena   = GetObjectByTag(CS_Lena);
            object oMaria  = GetObjectByTag(CS_Maria);
            object oDalan  = GetObjectByTag(CS_Dalan);
            object oBardas = GetObjectByTag(CS_Bardas);

            // Stage Movements
            object oWPBardas01 = GetWaypointByTag(CS_WPBardas01);
            object oWPBardas02 = GetWaypointByTag(CS_WPBardas02);
            object oWPHG1      = GetWaypointByTag(CS_WPHG101);

            // Props
            object oDoor = GetObjectByTag(CS_DoorBardas);

            // Camera
            StartCutscene(oPC, 350.0, 3.0, 75.0);
            FadeFromBlack(oPC, FADE_SPEED_FAST);
            DelayCommand(15.0, FadeToBlack(oPC, FADE_SPEED_FASTEST));
            DelayCommand(15.7, RemoveCutsceneEffects(oPC));
            DelayCommand(15.8, EndCutscene(0.0, 15.0, 50.0, SNAP));
            DelayCommand(16.0, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag(WC_StartMod)))));

//            DelayCommand(16.0, AssignCommand(oPC, JumpToObject(GetWaypointByTag(WC_StartMod))));
//            DelayCommand(16.5, FadeFromBlack(oPC,FADE_SPEED_FAST));

            // Action
            DelayCommand( 1.0, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
            DelayCommand( 1.4, AssignCommand(oBardas, JumpToObject(oWPBardas01)));
            DelayCommand( 1.5, AssignCommand(oBardas, ActionMoveToObject(oWPBardas02, FALSE, 0.2)));
            DelayCommand( 2.5, AssignCommand(oBardas, SpeakString(sLineBardas1)));
            DelayCommand( 4.0, AssignCommand(oDalan, TurnToFaceObject(oBardas)));
            DelayCommand( 5.0, AssignCommand(oDalan, SpeakString(sLineDalan4)));
            DelayCommand( 7.5, AssignCommand(oMaria, SpeakString(sLineMaria4)));
            DelayCommand(11.5, AssignCommand(oLena, SpeakString(sLineLena4)));
            DelayCommand(13.0, AssignCommand(oLena, SpeakString(sLineLena5)));
            DelayCommand(13.1, AssignCommand(oLena, TurnToFaceObject(GetWaypointByTag("WP_Hobgoblin1_01"))));
        }; break;
    }
}
