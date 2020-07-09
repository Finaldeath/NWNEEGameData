//::///////////////////////////////////////////////
//:: aen_a3_shgnpssg
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A player object has entered the Sahaugin
    Passage of the Troglodyte Island. Do a
    single player autosave.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_a3_rgbpzzl"

void PaintRed(object oPlacable);
void PaintGreen(object oPlacable);
void PaintBlue(object oPlacable);
void PaintPurple(object oPlacable);

void SourceRed(object oPlacable);
void SourceGreen(object oPlacable);
void SourceBlue(object oPlacable);
void SourcePurple(object oPlacable);

void ApplyAOE(object oTarget, effect eAOE);
void AdjustHeight(object oTarget, float fHeight = -0.10f);

void main()
{
    object oModule = GetModule();
    object oArea = OBJECT_SELF;
    object oCursor = OBJECT_INVALID;
    object oEnter = GetEnteringObject();
    object oVFXHolder = OBJECT_INVALID;
    vector vVFXHolder;
    location lVFXHolder;

    string sVFXHolder = S_VFXHOLDER + GetPCPublicCDKey(oEnter) + GetName(oEnter);

    int iDoOnce = GetLocalInt(oModule, "aen_a3_shgnpssg");

    if ((GetIsPC(oEnter) == TRUE) && (GetIsDM(oEnter) == FALSE))
    {
        //vVFXHolder.x = 1.0f;
        //vVFXHolder.y = 1.0f;
        //vVFXHolder.z = -1.0f;
        //lVFXHolder = Location(oArea, vVFXHolder, 0.0f);

        //lVFXHolder = GetLocation(oEnter);
        //oVFXHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_vfx_storage", lVFXHolder, FALSE, sVFXHolder);
        //SetPlotFlag(oVFXHolder, TRUE);

        ExecuteScript("exe_autosave", GetModule());

        if (iDoOnce == FALSE)
        {
            SetLocalInt(oModule, "aen_a3_shgnpssg", TRUE);

            oCursor = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                // Activate Pillars
                if (GetTag(oCursor) == "plc_a3_srcgreen")
                {
                    PaintGreen(oCursor);
                    SourceGreen(oCursor);
                }
                else if(GetTag(oCursor) == "plc_a3_srcblue")
                {
                    PaintBlue(oCursor);
                    SourceBlue(oCursor);
                }
                else if (GetTag(oCursor) == "plc_a3_srcred")
                {
                    PaintRed(oCursor);
                    SourceRed(oCursor);
                }
                else if (GetTag(oCursor) == "plc_a3_srcpurple")
                {
                    PaintPurple(oCursor);
                    SourcePurple(oCursor);
                }

                // Activate Barricades
                if (GetTag(oCursor) == "plc_blbrrcd")
                {
                    PaintBlue(oCursor);
                    AdjustHeight(oCursor);
                }
                else if(GetTag(oCursor) == "plc_grnbrrcd")
                {
                    PaintGreen(oCursor);
                    AdjustHeight(oCursor);
                }
                else if (GetTag(oCursor) == "plc_prplbrrcd")
                {
                    PaintPurple(oCursor);
                    AdjustHeight(oCursor);
                }
                else if (GetTag(oCursor) == "plc_redbrrcd")
                {
                    PaintRed(oCursor);
                    AdjustHeight(oCursor);
                }

                oCursor = GetNextObjectInArea(oArea);
            }
        }
    }
}

void DelayableCopy(object oTarget, location lTarget)
{
    object oCopy = CreateObject(OBJECT_TYPE_PLACEABLE, GetResRef(oTarget), lTarget);
    effect eCursor;

    eCursor = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eCursor) == TRUE)
    {
        ApplyEffectToObject(GetEffectDurationType(eCursor), eCursor, oCopy);
        eCursor = GetNextEffect(oTarget);
    }
    DestroyObject(oTarget, 0.1f);
}

void AdjustHeight(object oTarget, float fHeight = -0.10f)
{
    vector vPosition = GetPosition(oTarget);
    float fOrientation = GetFacing(oTarget);

    vPosition.z = -0.2f;

    location lTarg = Location(GetArea(oTarget), vPosition, fOrientation);

    DelayCommand(1.0f, DelayableCopy(oTarget, lTarg));
}

void ApplyAOE(object oTarget, effect eAOE)
{
    location lTarg = GetLocation(oTarget);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eAOE, lTarg);
}

// Barricade Effects
void PaintRed(object oPlacable)
{
    effect eVFXRed = EffectVisualEffect(VFX_DUR_GLOW_RED);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXRed, oPlacable);
}

void PaintGreen(object oPlacable)
{
    effect eVFXGreen = EffectVisualEffect(VFX_DUR_GLOW_GREEN);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXGreen, oPlacable);
}

void PaintBlue(object oPlacable)
{
    effect eVFXBlue = EffectVisualEffect(VFX_DUR_GLOW_BLUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXBlue, oPlacable);
}

void PaintPurple(object oPlacable)
{
    effect eVFXPurple = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXPurple, oPlacable);
}

// Source Pillar effects
void SourceRed(object oPlacable)
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_DRAGON_FEAR, "exe_a3_redsrc");
    AssignCommand(oPlacable, ApplyAOE(oPlacable, eAOE));
}
void SourceGreen(object oPlacable)
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_DRAGON_FEAR, "exe_a3_grnsrc");
    AssignCommand(oPlacable, ApplyAOE(oPlacable, eAOE));
}
void SourceBlue(object oPlacable)
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_DRAGON_FEAR, "exe_a3_blsrc");
    AssignCommand(oPlacable, ApplyAOE(oPlacable, eAOE));
}
void SourcePurple(object oPlacable)
{
    effect eAOE = EffectAreaOfEffect(AOE_MOB_DRAGON_FEAR, "exe_a3_prplsrc");
    AssignCommand(oPlacable, ApplyAOE(oPlacable, eAOE));
}
