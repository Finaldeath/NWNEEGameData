//Direct PC-friendly NPCs in Kur-Tharsu Main Gate area

#include "nw_i0_generic"
#include "x0_i0_position"

#include "hf_in_friend"
#include "hf_in_plot"

//Blizzard uses Cone of Cold on Gates of Kur-Tharsu
void ApplyConeOfCold(object oGate)
{
    object oPortcullis = GetNearestObjectByTag("KTPortcullis");

    effect eCold = EffectDamage(20, DAMAGE_TYPE_COLD);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);

    float fDelay = GetDistanceBetween(OBJECT_SELF, oGate) / 20.0;

    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPortcullis));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oGate));
}

//Friends follow, attacking when appropriate
void FriendFollow(object oPC, float fFollowDistance)
{
    float fDistance = GetDistanceBetween(OBJECT_SELF, oPC);

    object oEnemy = GetNearestPerceivedEnemy(OBJECT_SELF);

    if(fDistance <= 0.0 || fDistance > 25.0)
    {
        ClearAllActions(TRUE);
        JumpToLocation(GetBehindLocation(oPC));
    }
    else
    if(oEnemy != OBJECT_INVALID && (GetArea(oEnemy) == GetArea(OBJECT_SELF)))
    {
        ClearAllActions();
        DetermineCombatRound(oEnemy);
    }
    else
    {
        if(GetCurrentAction() != ACTION_FOLLOW)
        {
            ActionForceFollowObject(oPC, fFollowDistance);
        }
    }
}

void main()
{
    float fBlizzardDistance = 3.5;
    float fElfDistance = 5.5;

    string sArea;
    string sHome;

    object oBlizzard = GetLocalObject(OBJECT_SELF, "oBlizzard");
    object oElf = GetLocalObject(OBJECT_SELF, "oElf");
    object oPC = GetFirstPC();
    object oWrecker = GetLocalObject(OBJECT_SELF, "oWrecker");

    //Direct Blizzard in Kur-Tharsu
    if(GetIsObjectValid(oBlizzard) && !GetIsInCombat(oBlizzard) &&
       !GetIsDead(oBlizzard) && !FriendIsDead(oBlizzard) &&
       GetCurrentAction(oBlizzard) != ACTION_CASTSPELL &&
       !IsInConversation(oBlizzard) && GetLocalInt(oBlizzard, "nCutsceneMode") == 0)
    {
        //If PC enters World Map send Blizzard to home location in Kur-Tharsu Gate area
        sArea = GetTag(GetArea(oPC));

        if(sArea == "WorldMap" &&
          PlotLevelGet("Blizzard") > 10 && PlotLevelGet("Blizzard") < 17)
        {
            sHome = GetLocalString(oBlizzard, "sHome");

            AssignCommand(oBlizzard, ClearAllActions(TRUE));
            AssignCommand(oBlizzard,
                JumpToLocation(GetLocation(GetWaypointByTag(sHome))));
        }
        //If PC leaves Kur-Tharsu with Blizzard following, send her to home location
        else
        if(PlotLevelGet("Blizzard") > 10 && PlotLevelGet("Blizzard") < 17 &&
           sArea != "TharKurSMG" &&
           sArea != "TharKurTharsuStrongholdCourtyard" &&
           sArea != "TharKurTharsuStrongholdGroundFlo")
        {
            sHome = GetLocalString(oBlizzard, "sHome");

            AssignCommand(oBlizzard, ClearAllActions(TRUE));
            AssignCommand(oBlizzard,
                JumpToLocation(GetLocation(GetWaypointByTag(sHome))));
        }
        //Follow PC to gate
        else if(PlotLevelGet("Blizzard") == 11)
        {
            //Keep Blizzard close while Invisibility Sphere is running
            if(GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oBlizzard))
            {
                fBlizzardDistance = 1.0;
            }

            AssignCommand(oBlizzard, FriendFollow(oPC, fBlizzardDistance));
        }
        //Arrived at gate
        else if(PlotLevelGet("Blizzard") == 12)
        {
            AssignCommand(oBlizzard, ClearAllActions(TRUE));
            AssignCommand(oBlizzard,
                ActionForceMoveToObject(GetWaypointByTag("WP_THKTMG_BLIZZARDGATE"),
                                        TRUE, 1.0, 4.0));
            AssignCommand(oBlizzard,
                ActionDoCommand(
                    SetFacingPoint(GetPosition(GetNearestObjectByTag("KurTharsuMainGate")))));
        }
        //Attack gate
        else if(PlotLevelGet("Blizzard") == 13)
        {
            object oGate = GetNearestObjectByTag("KTPortcullis");
            object oGateCreature = GetNearestObjectByTag("KurTharsuMainGate");

            AssignCommand(oBlizzard, ClearAllActions(TRUE));
            AssignCommand(oBlizzard,
                ActionCastFakeSpellAtObject(SPELL_CONE_OF_COLD, oGate));
            AssignCommand(oBlizzard, ActionDoCommand(ApplyConeOfCold(oGateCreature)));
        }
        //Gate is destroyed
        else if(PlotLevelGet("Blizzard") == 14 || PlotLevelGet("Blizzard") == 15)
        {
            AssignCommand(oBlizzard, FriendFollow(oPC, fBlizzardDistance));
        }
        //In Ground Floor area
        else if(PlotLevelGet("Blizzard") == 16)
        {
            AssignCommand(oBlizzard, FriendFollow(oPC, fBlizzardDistance));
        }
        //In Ground Floor area and about to depart
        else if(PlotLevelGet("Blizzard") == 17)
        {
            if(!IsInConversation(oPC) && !GetIsInCombat(oPC) &&
               GetLocalInt(oBlizzard, "HF_EXIT_STARTED") == 0)
            {
                AssignCommand(oBlizzard, ClearAllActions());
                AssignCommand(oBlizzard, ActionStartConversation(oPC, "", FALSE, FALSE));
            }
        }
    }

    //Direct Elf in Kur-Tharsu and Scarred Lands
    if(GetIsObjectValid(oElf) && !GetIsInCombat(oElf) &&
       !GetIsDead(oElf) && !FriendIsDead(oElf) &&
       !IsInConversation(oElf) && GetLocalInt(oElf, "nCutsceneMode") == 0)
    {
        //If PC enters World Map send Elf to appropriate home location
        sArea = GetTag(GetArea(oPC));

        if(sArea == "WorldMap" &&
          PlotLevelGet("Elf") > 12 && PlotLevelGet("Elf") < 21)
        {
            sHome = GetLocalString(oElf, "sHome");

            AssignCommand(oElf, ClearAllActions(TRUE));
            AssignCommand(oElf,
                JumpToLocation(GetLocation(GetWaypointByTag(sHome))));
        }
        else
        //If PC leaves Scarred Lands with Elf following, send Elf to home location
        if((PlotLevelGet("Elf") ==13 || PlotLevelGet("Elf") == 14) &&
           sArea != "TharScar")
        {
            sHome = GetLocalString(oElf, "sHome");

            AssignCommand(oElf, ClearAllActions(TRUE));
            AssignCommand(oElf,
                JumpToLocation(GetLocation(GetWaypointByTag(sHome))));
        }
        //If PC leaves Kur-Tharsu with Elf following, send Elf to home location
        else
        if(PlotLevelGet("Elf") > 15 && PlotLevelGet("Elf") < 21 &&
           sArea != "TharKurSMG" &&
           sArea != "TharKurTharsuStrongholdCourtyard" &&
           sArea != "TharKurTharsuStrongholdGroundFlo")
        {
            sHome = GetLocalString(oElf, "sHome");

            AssignCommand(oElf, ClearAllActions(TRUE));
            AssignCommand(oElf,
                JumpToLocation(GetLocation(GetWaypointByTag(sHome))));
        }
        else if(GetLocalInt(oElf, "nGruumsh") == 1)
        {
            object oChapel = GetNearestObjectByTag("KTGruumsh", oElf);

            AssignCommand(oElf, ClearAllActions(TRUE));
            AssignCommand(oElf, ActionForceMoveToObject(oChapel, FALSE, 1.5, 8.0));
            AssignCommand(oElf, ActionDoCommand(SetFacingPoint(GetPosition(oChapel))));
            AssignCommand(oElf, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 3.0));
            AssignCommand(oElf, ActionSpeakString("I remember His gaze upon me... He still watches..."));
            AssignCommand(oElf, ActionDoCommand(DeleteLocalInt(oElf, "nGruumsh")));
        }
        //Follow PC through Scarred Lands
        else if(PlotLevelGet("Elf") == 13)
        {
            AssignCommand(oElf, FriendFollow(oPC, fElfDistance));
        }
        //Converse with PC after meeting Tusk
        else if(PlotLevelGet("Elf") == 14 && !GetIsInCombat(oPC))
        {
            AssignCommand(oElf, ClearAllActions());
            AssignCommand(oElf, ActionStartConversation(oPC));
        }
        //Follow PC to Kur-Tharsu gate
        else if(PlotLevelGet("Elf") == 16)
        {
            AssignCommand(oElf, FriendFollow(oPC, fElfDistance));
        }
        //Arrived at gate
        else if(PlotLevelGet("Elf") == 17)
        {
            AssignCommand(oElf, ClearAllActions());
            AssignCommand(oElf,
                ActionForceMoveToObject(GetWaypointByTag("WP_THKTMG_ELFGATE"),
                                        TRUE, 1.0, 4.0));
            AssignCommand(oElf,
                ActionDoCommand(
                    SetFacingPoint(GetPosition(GetNearestObjectByTag("KurTharsuMainGate")))));
        }
        //Gate is destroyed
        else if(PlotLevelGet("Elf") == 18 || PlotLevelGet("Elf") == 19)
        {
            AssignCommand(oElf, FriendFollow(oPC, fElfDistance));
        }
        //In Ground Floor area
        else if(PlotLevelGet("Elf") == 20)
        {
            AssignCommand(oElf, FriendFollow(oPC, fElfDistance));
        }
        //In Ground Floor area and about to depart
        else if(PlotLevelGet("Elf") == 21)
        {
            if(!IsInConversation(oPC) && !GetIsInCombat(oPC) &&
               GetLocalInt(oElf, "HF_EXIT_STARTED") == 0)
            {
                AssignCommand(oElf, ClearAllActions(TRUE));
                AssignCommand(oElf, ActionStartConversation(oPC, "", FALSE, FALSE));
            }
        }
    }

    //Direct The Wrecker in Kur-Tharsu
    if(PlotLevelGet("TheWrecker") == 2)
    {
        if(GetIsObjectValid(oWrecker) && !GetIsDead(oWrecker) && !IsInConversation(oWrecker))
        {
            //Attack the gate
            AssignCommand(oWrecker, ActionAttack(GetObjectByTag("KurTharsuMainGate")));
        }
    }
    //Gate is destroyed
    else if(PlotLevelGet("TheWrecker") == 3)
    {
        if(GetIsObjectValid(oWrecker) && !GetIsDead(oWrecker) && !IsInConversation(oWrecker))
        {
            AssignCommand(oWrecker, ClearAllActions(TRUE));
            float fDistance = GetDistanceBetween(oWrecker, oPC);
            if(fDistance > 0.0 && fDistance < 10.0)
            {
                AssignCommand(oWrecker, ActionStartConversation(oPC));
            }
        }
    }
}
