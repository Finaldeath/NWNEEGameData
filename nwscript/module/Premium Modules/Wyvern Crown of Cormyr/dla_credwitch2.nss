//::///////////////////////////////////////////////
//:: Name dla_credwitch2
//:://////////////////////////////////////////////
/*
    Witch Lord deaths have visual effects
    this one trigger also the ending cutscene
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: March 2006
//:: Last Update: 6th August
//:://////////////////////////////////////////////
#include "cu_functions"

// added by gaoneng erick
// august 5, 2006

// Modified B G P Hughes - tweaks to lich visuals (max delay is 4.0, after this the body has gone and it won't fire)

void dlag_PartyEscape()
{
    object self = OBJECT_SELF;
    object exit = GetNearestObjectByTag("CBDoorExit");
    object epiwp = GetWaypointByTag("TP_TFPC");

    int i = 1;
    object hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, self, i);
    while (GetIsObjectValid(hench))
    {
        AssignCommand(hench, ClearAllActions());
        AssignCommand(hench, ActionPlayAnimation(109 + Random(3)));
        AssignCommand(hench, ActionWait(4.0));
        AssignCommand(hench, ActionMoveToObject(exit));
        hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, self, ++i);
    }

    ClearAllActions();
    ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
    ActionWait(4.0);
    ActionMoveToObject(exit);

    DelayCommand(10.0, FadeToBlack(self));
    DelayCommand(10.5, ClearAllActions());
    DelayCommand(11.0, JumpToObject(epiwp));
}

void dlag_CameraMovements()
{
    object self = OBJECT_SELF;
    float face = GetFacing(self);
    SetCameraFacing(face + 180.0, 10.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
    DelayCommand(6.0, SetCameraFacing(face, 22.0, 40.0, CAMERA_TRANSITION_TYPE_SLOW));
}

void dlag_RemoveAllEffects(object target)
{
    effect e = GetFirstEffect(target);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(target, e);
        e = GetNextEffect(target);
    }
    ForceRest(target);
}

// as the witch dude has Fear aura, and probably other effects, this remove all
// effects call is necessary to return control back to the player.
void dlag_RestoreParty(object pc)
{
    int i = 1;
    object hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, pc, i);
    while (GetIsObjectValid(hench))
    {
        dlag_RemoveAllEffects(hench);
        hench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, pc, ++i);
    }
    dlag_RemoveAllEffects(pc);
    if (GetIsDead(pc)) // in case pc dies for whatever weird reasons after effects are removed
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), pc);
        ForceRest(pc);
    }
}
// end add

void main()
{
//    location lLoc = GetLocation(GetWaypointByTag("TP_TFPC"));
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
    effect eKill = EffectVisualEffect(496);
    effect eDrain = EffectVisualEffect(VFX_IMP_DEATH);
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,OBJECT_SELF));
    DelayCommand(3.3,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrain,OBJECT_SELF));
//    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    AssignCommand(oPC,ClearAllActions(TRUE));
    BeHappy(oPC);
    SetCutsceneMode(oPC,TRUE);
    object oArea = GetArea(OBJECT_SELF);
    object oKill = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oKill))
    {
// modified by gaoneng erick
// GetIsEnemy works on placeables too, and this was destroying everything...
// so added an object type check
//        if(GetIsEnemy(oKill,oPC)&&oKill!=OBJECT_SELF)
        if(GetObjectType(oKill) == OBJECT_TYPE_CREATURE && GetIsEnemy(oKill, oPC) && oKill != OBJECT_SELF) // end mod
        {
            DestroyObject(oKill);
        }
        oKill = GetNextObjectInArea(oArea);
    }

// added by gaoneng erick

// moved to dlag_PartyEscape()
//    AssignCommand(oPC,DelayCommand(5.5,FadeToBlack(oPC,FADE_SPEED_SLOWEST)));
//    AssignCommand(oPC,DelayCommand(6.5,JumpToLocation(lLoc)));

    object self = OBJECT_SELF;
    object pc = oPC;

    dlag_RestoreParty(pc); // remove all ill-effects like fear and dominate so player can "act"
    if (GetDistanceBetween(pc, self) > 5.0) AssignCommand(pc, JumpToObject(self)); // if player is too far away, jump closer so player can see the witch dude die
    AssignCommand(pc, dlag_CameraMovements()); // some camera swings
    AssignCommand(pc, DelayCommand(6.0, dlag_PartyEscape())); // party play victory anim, walk to exit, and jump to epilogue
//end add
}
