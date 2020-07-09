//::///////////////////////////////////////////////
//:: inc_bubbles
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Apply and remove bubble effects from an object
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

void CreateBubbles(object oTarget);
void ApplyBubbles(object oTarget);
void RemoveBubbles(object oTarget);

void CreateBubbles(object oTarget)
{
    //tiny bubbles...
    location lSpawn = GetLocation(oTarget);
    object oVFXHolder;

    oVFXHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_vfx_storage", lSpawn);
    AssignCommand(oVFXHolder, ApplyBubbles(oTarget));

    SetLocalObject(oTarget, "oVFXHolder", oVFXHolder);
}

void ApplyBubbles(object oTarget)
{
    //tiny bubbles...
    effect eBubbles = EffectVisualEffect(513);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBubbles, oTarget);
}

void RemoveBubbles(object oTarget)
{
    //tiny bubbles...bye bye
    object oVFXHolder = GetLocalObject(oTarget, "oVFXHolder");
    effect eBubbles = GetFirstEffect(oTarget);

    while (GetIsEffectValid(eBubbles) == TRUE)
    {
        if (GetEffectCreator(eBubbles) == oVFXHolder)
        {
            DelayCommand(0.5f, RemoveEffect(oTarget, eBubbles));
        }

        eBubbles = GetNextEffect(oVFXHolder);
    }

    DeleteLocalObject(oTarget, "oVFXHolder");
    DestroyObject(oVFXHolder);
}
