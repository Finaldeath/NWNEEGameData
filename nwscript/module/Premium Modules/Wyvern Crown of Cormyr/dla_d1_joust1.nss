//::///////////////////////////////////////////////
//:: dla_d1_joust1
//:: DLA Wyvern Crown of Cormyr
//:://////////////////////////////////////////////
/*
    Joust conversation action script that creates the jousting opponent,
    prepares the PC for the match and then calls the cutscene function to pick
    a lance.
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 2 Mar 2006
//:://////////////////////////////////////////////
/* Change History

   2006/06/25  Syrsnein  Added delays within PrepRider().
                         Moved tail changing code to a seperate function
                            within dla_i0_joust.
   2006/06/29  Syrsnein  Cleaned up code.  Grouped code into private functions
                          for delayed execution.  Reworked timing.
   2006/07/12  Syrsnein  Moved first lance selection function into this script.
   2006/07/31  Syrsnein  Removed condition to start lance selection conversation
                          as it is done in the converstation with Thiodor.
 */

// include "dla_i0_horse" included in dla_i0_joust, Syrsnein
#include "dla_i0_feats"
#include "dla_i0_joust"

void privateCreateOpponent(object oPC)
{
    // Create the opponent, save them to the PC and set the opponent up for the
    // the joust
    object oOP = DLA_SpawnOpponent(oPC);
    SetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT, oOP);
    DLA_SetupOpponent(oPC);

    // Get some information from the opponent for dialogues
    string sGender = (GetGender(oOP)==GENDER_MALE) ? "he" : "she";
    SetLocalString(oPC, "OpGender", sGender);
}

void privateApplyStrengthBonus(object oPC)
{    //Gale 16 Jan 2006: Temp boost to str to don't be encumbered
    //Syrs: Make Hurim the creator so we can remove these easily later.
    effect eStrBonus = EffectAbilityIncrease(ABILITY_STRENGTH, 12);
    object oHurim = GetObjectByTag("HurimJoust1");
    AssignCommand(oHurim, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStrBonus, oPC));
}

void privatePrepRider(object oPC)
{
    // Mount the PC if they are not mounted.
    if (!DLA_GetIsMounted(oPC))
    {
        object oHorse = DLA_GetWarhorse(oPC);
        DLA_JoustDebug("dla_d1_joust1()");
        DLA_JoustDebug("   Mounting " + GetName(oPC) + " on " + GetName(oHorse) + ".");
        DLA_Mount(oPC, oHorse, FALSE);
    }
    // Change to joust colors
    DelayCommand(1.5, DLA_ChangeToJoustColors(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();

    if (!GetCutsceneMode(oPC))
    {
        SetCutsceneMode(oPC);
    }

    float fCueTime = 0.0;
    int nAppearance = GetAppearanceType(oPC);

    int bTraining = DLA_GetIsOnTraining(oPC);

    // Give the PC the feats they will need to joust
    DLA_GiveFeat(oPC, IP_CONST_FEAT_ARMOR_PROF_HEAVY  );
    DLA_GiveFeat(oPC, IP_CONST_FEAT_SHIELD_PROFICIENCY);

    // Clear action modes
    if (GetActionMode(oPC, ACTION_MODE_DETECT))
        SetActionMode(oPC, ACTION_MODE_DETECT, FALSE);
    if (GetActionMode(oPC, ACTION_MODE_STEALTH))
        SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);

    // Fade out and set up the cutscene
    FadeToBlack(oPC, FADE_SPEED_FAST);
    // Setup the opponent
    DelayCommand(fCueTime+=1.2, privateCreateOpponent(oPC));
    // Prep the PC as a rider
    DelayCommand(fCueTime+=0.1, privatePrepRider(oPC));
    // Jump henchmen to WP_Associates
    DelayCommand(fCueTime+=2.0, DLA_JumpAssociatesToWaypoint(oPC, GetObjectByTag("WP_Associates")));
    // Force associates to stay where they are
    DelayCommand(fCueTime+=0.1, DLA_SetAssociateStandGround(oPC));
    // Apply strength bonuses so that characters don't become encumbered
//    DelayCommand(fCueTime+=2.0, privateApplyStrengthBonus(oPC));
    // Equip the PC if needed  (do this after preping the rider so we know our colors)
//    DelayCommand(fCueTime+=0.2, DLA_EquipJoustingItems(oPC, DLA_EQUIP_ARMOR));
    // Clean up some local vars
    DelayCommand(fCueTime+=0.1, DLA_RemoveHasJoustMatch(oPC));
    // Start the lance selection cutscene
//    DelayCommand(fCueTime+=0.1, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
//    DelayCommand(fCueTime+=0.1, DLA_CutsceneLanceRack(oPC));

    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_WRACK_PC")))));
    DelayCommand(fCueTime+=1.0, FadeFromBlack(oPC, FADE_SPEED_FAST));

/* Syrsnein: 31 July 2006
    Changed lance selection routine.  need only to execute dla_jst_lancerak now

    if (DLA_JoustGetLanceColor(oPC) > 0)
    {
        DelayCommand(fCueTime+=1.2, ExecuteScript("dla_jst_lancerak", oPC));
    }
    else
    {
        object oInvis = GetObjectByTag("lance_rackinv");
        DelayCommand(fCueTime+=1.2, AssignCommand(oPC, ActionStartConversation(oInvis, "dla_lancech", TRUE, FALSE)));
    }
 */
    DelayCommand(fCueTime+=1.2, ExecuteScript("dla_jst_lancerak", oPC));
}
