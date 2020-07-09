//Track number of dead enemies in final Elventree battle

#include "hf_in_henchman"
#include "hf_in_util"


const string NPC_TAG_SHARALYN = "SharalynElventree";
const string NPC_TAG_HILRAD = "HilradthePatient";
const string NPC_TAG_ASTAR = "Astar";
const string NPC_TAG_LYRESSA = "Lyressa";
const string NPC_TAG_EREMUTH = "Eremuth";

const string WP_TAG_LYRESSA_JUMP = "WP_cut_astdeath_lyressa_init";

const string WP_TAG_NEXT_CUTSCENE = "WP_cut_elventree_pc_init";


// Remove old NPCs. New ones will be spawned for the cutscene
void RemoveSharalynHirlad(object oPC)
{
    object oSharalyn = GetNearestObjectByTag(NPC_TAG_SHARALYN, oPC);
    if (GetIsObjectValid(oSharalyn))
        DestroyObject(oSharalyn);

    object oHilrad = GetNearestObjectByTag(NPC_TAG_HILRAD, oPC);
    if (GetIsObjectValid(oHilrad))
        DestroyObject(oHilrad);
}


// Removes henchmen only
void RemoveHenchmen(object oPC)
{
    object oElventreeWP = GetWaypointByTag(WP_TAG_NEXT_CUTSCENE);

    // Astar will be killed in a cutscene
    object oAstar = GetObjectByTag(NPC_TAG_ASTAR);
    object oAstarMaster = GetMaster(oAstar);
    if (GetIsObjectValid(oAstar))
    {
        if (GetIsObjectValid(oAstarMaster))
        {
            SetActionMode(oAstar, ACTION_MODE_STEALTH, FALSE);
            RemoveHenchman(oAstarMaster, oAstar);
        }
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oAstar);
    }

    // We don't need Eremuth any longer, he fled
    object oEremuth = GetObjectByTag(NPC_TAG_EREMUTH);
    if (GetIsObjectValid(oEremuth))
        DestroyObject(oEremuth);

    // Lyressa needs to be moved to swaying bough
    // Remove all effects from Lyressa
    object oLyressa = GetObjectInArea(NPC_TAG_LYRESSA, oElventreeWP);
    if (!GetIsObjectValid(oLyressa))
        oLyressa = GetObjectByTag(NPC_TAG_LYRESSA);
    // Remove all Effects from her
    effect eEffect = GetFirstEffect(oLyressa);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oLyressa, eEffect);
        eEffect = GetNextEffect(oLyressa);
    }
    // She might be unconscious ("dead" henchman)
    // Use OBJECT_INVALID instead of oPC, to prevent re-adding her as hench (we do not want that)
    HenchmanRaise(oLyressa, OBJECT_INVALID);
    // Move Lyressa to Swaying Bough
    object oLyressaMaster = GetMaster(oLyressa);
    object oLyressaJump = GetWaypointByTag(WP_TAG_LYRESSA_JUMP);
    if (GetIsObjectValid(oLyressaMaster))
    {
        SetActionMode(oLyressa, ACTION_MODE_STEALTH, FALSE);
        RemoveHenchman(oLyressaMaster, oLyressa);
    }
    AssignCommand(oLyressa, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oLyressa, JumpToLocation(GetLocation(oLyressaJump))));
}


// Cleanup any lingering Aoe around target location
void RemoveLingeringAoe(location lCenter, float fRange = 20.0f)
{
    object oAOE = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lCenter, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    while (oAOE != OBJECT_INVALID)
    {
        DestroyObject(oAOE);
        oAOE = GetNextObjectInShape(SHAPE_SPHERE, fRange, lCenter, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    }
}


void JumpToCutscene(object oPC)
{
    location lJumpLocation = GetLocation(GetWaypointByTag(WP_TAG_NEXT_CUTSCENE));

    SetLocalInt(oPC, "elventreefinale", 1);

    FadeToBlack(oPC, FADE_SPEED_FAST);

    RemoveLingeringAoe(lJumpLocation);

    DelayCommand(0.6f, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(1.2f, AssignCommand(oPC, JumpToLocation(lJumpLocation)));
}


void main()
{
    int iCount = 0;

    switch(GetUserDefinedEventNumber())
    {
        case 4000 :
            iCount = GetLocalInt(OBJECT_SELF, "iElventreeDeadCount") + 1;

            SetLocalInt(OBJECT_SELF, "iElventreeDeadCount", iCount);

            if(iCount == 25)
            {
                object oPC = GetFirstPC();

                RemoveHenchmen(oPC);
                RemoveSharalynHirlad(oPC);
                DelayCommand(0.5f, JumpToCutscene(oPC));
            }
        break;
    }
}
