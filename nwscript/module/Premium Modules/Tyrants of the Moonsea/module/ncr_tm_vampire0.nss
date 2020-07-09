
#include "hf_in_plot"


const string LVAR_MOVE_TAG = "vamp_flee";
const string LVAR_COFFIN_TAG = "vamp_coffin";

// Set to mark coffin as occupied
const string LVAR_COFFIN_IS_OCCUPIED = "vamp_coffin_occupied";


// Will move the target towards the nearest move object with the tag
void MoveToCoffin(object oTarget, string sMoveTag)
{
    float fDelay = 5.0f;
    if (sMoveTag != "")
    {
        object oDestination = GetNearestObjectByTag(sMoveTag, oTarget, 1);
        float fDelay = GetDistanceBetween(oTarget, oDestination)/1.4f;

        AssignCommand(oTarget, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oTarget, ActionMoveToObject(oDestination)));
    }
    DestroyObject(oTarget, fDelay);
}


// Will mark the nearest (unoccupied) coffin as occupied
void OccupyCoffin(object oTarget, string sCoffinTag)
{
    if (sCoffinTag == "")
        return;

    int i = 1;
    object oCoffin = GetNearestObjectByTag(sCoffinTag, oTarget, i);
    while (GetIsObjectValid(oCoffin))
    {
        if (GetLocalInt(oCoffin, LVAR_COFFIN_IS_OCCUPIED) == 0)
        {
            SetLocalInt(oCoffin, LVAR_COFFIN_IS_OCCUPIED, 1);
            SetPlotFlag(oCoffin, FALSE);
            return;
        }

        i++;
        oCoffin = GetNearestObjectByTag(sCoffinTag, oTarget, i);
    }
}


void ClearFollowerReputation(object oPC, object oTarget)
{
    int i = 1;

    // Henchmen
    object oHench = OBJECT_INVALID;
    for (i=1; i<=20; i++)
    {
        oHench = GetHenchman(oPC, i);
        if (GetIsObjectValid(oHench))
        {
            ClearPersonalReputation(oTarget, oHench);
            ClearPersonalReputation(oHench, oTarget);
        }
    }

    // Other associates
    object oAssociate = OBJECT_INVALID;
    for (i = ASSOCIATE_TYPE_ANIMALCOMPANION; i <= ASSOCIATE_TYPE_DOMINATED; i++)
    {
        oAssociate = GetAssociate(i, oPC);
        if (GetIsObjectValid(oAssociate))
        {
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            ClearPersonalReputation(oTarget, oAssociate);
            ClearPersonalReputation(oAssociate, oTarget);
       }
    }
}


void GaseousFormAppearance(object oTarget)
{
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oTarget);
    DelayCommand(0.4, SetCreatureAppearanceType(oTarget, 818));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_SMOKE), oTarget));

}


void main()
{
    if ( (GetCurrentHitPoints() <= 2) && (GetLocalInt(OBJECT_SELF, "iFlee") == 0) )
    {
        object oPC = GetFirstPC();

        SetLocalInt(OBJECT_SELF, "iFlee", 1);
        SetLocalInt(OBJECT_SELF, "nBusy", 1);

        SetPlotFlag(OBJECT_SELF, TRUE);
        ClearAllActions(TRUE);

        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_MERCHANT);

        SurrenderToEnemies();
        ClearPersonalReputation(oPC, OBJECT_SELF);
        ClearPersonalReputation(OBJECT_SELF, oPC);
        ClearFollowerReputation(oPC, OBJECT_SELF);

        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_FNF_SMOKE_PUFF),
                            OBJECT_SELF);
        GaseousFormAppearance(OBJECT_SELF);

        string sDestinationTag = GetLocalString(OBJECT_SELF, LVAR_MOVE_TAG);
        MoveToCoffin(OBJECT_SELF, sDestinationTag);

        string sCoffinTag = GetLocalString(OBJECT_SELF, LVAR_COFFIN_TAG);
        OccupyCoffin(OBJECT_SELF, sCoffinTag);
    }
    else
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}
