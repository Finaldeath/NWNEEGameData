//::///////////////////////////////////////////////
//::
//:: a3_bw_ou_place
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Use script for placeables.
//::
//:: Handles code for usable placeables in Illefarn.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/3/2005
//::
//:://////////////////////////////////////////////

#include "x0_i0_position"

void OpenPortal(location lLocation);

void CreateBlockTop(location lLoc);

void main()
{
    object oUser = GetLastUsedBy();
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "ar2504_cball")
    {
        object oPortal = GetNearestObjectByTag("ar2504_portal");
        if (!GetIsObjectValid(oPortal))
        {
            if (GetLocalInt(oUser, "nIH_KnowsExit") == 1)
            {
                object oMe = OBJECT_SELF;

                AssignCommand(oUser, ClearAllActions());
                AssignCommand(oUser, ActionMoveToObject(oMe, FALSE, 0.3));
                AssignCommand(oUser, ActionDoCommand(TurnToFaceObject(oMe, oUser)));
                AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.8));

                effect eFX = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
                DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, OBJECT_SELF));

                object oWP = GetNearestObjectByTag("wp_ar2504_porter");
                location lLoc = GetLocation(oWP);

                effect eFire = EffectVisualEffect(VFX_IMP_FLAME_M);
                DelayCommand(2.6, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, lLoc));

                DelayCommand(3.0, OpenPortal(lLoc));
            }
        }
    }
    else if (sTag == "bw_false_door")
    {
        if (GetLocalInt(OBJECT_SELF, "nOpen") == 0)
        {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
            SetLocalInt(OBJECT_SELF, "nOpen", 1);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("This door leads nowhere!", oUser);
        }
    }
    else if (sTag == "ar2502_pillar1")
    {
        object oDoor = GetNearestObjectByTag("ar2502_temple_dr");
        if (GetLocked(oDoor))
        {
            object oArea = GetArea(OBJECT_SELF);

            if (GetLocalInt(oArea, "nIH_BeamActive") == 1)
            {
                FloatingTextStringOnCreature("Can't use that now.", oUser);
            }
            else
            {
                PlaySound("as_sw_genericlk1");

                object oCrystal = GetNearestObjectByTag("bw_mirror_33");
                AssignCommand(oCrystal, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
                DelayCommand(0.8, SignalEvent(oCrystal, EventUserDefined(501)));
                DelayCommand(7.0, AssignCommand(oCrystal, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));

                SetLocalInt(oArea, "nIH_BeamActive", 1);
                DelayCommand(7.2, SetLocalInt(oArea, "nIH_BeamActive", 0));
            }
        }
        else
        {
            FloatingTextStringOnCreature("Nothing happens.", oUser);
        }
    }
    else if (sTag == "ar2502d_lever")
    {
        object oDoor = GetNearestObjectByTag("ar2502d_lock_door");

        if (GetLocked(oDoor))
        {
            object oBlock = GetNearestObjectByTag("bw_stone_block");

            float fDist = GetDistanceToObject(oBlock);

            if ((fDist > 0.0f) && (fDist < 15.0f))
            {
                DelayCommand(0.2, AssignCommand(oBlock, PlaySound("as_dr_x2tib1cl")));

                SetPlotFlag(oBlock, FALSE);

                effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
                DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDust, oBlock));

                effect eDam = EffectDamage(500);
                DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oBlock));

                location lLoc = GetLocation(oBlock);
                DelayCommand(0.5, CreateBlockTop(lLoc));
            }

            DelayCommand(1.8, SetLocked(oDoor, FALSE));
        }
    }
    else if (sTag == "ar2502d_rubble")
    {
        if (GetLocalInt(OBJECT_SELF, "nDiscovered") == 1)
        {
            FloatingTextStringOnCreature("A mechanism is hidden under these stones.", oUser);
        }
        else if (GetLocalInt(oUser, "nIH_ar2502d_rubble") == 0)
        {
            if (GetIsSkillSuccessful(oUser, SKILL_SEARCH, 10))
            {
                DelayCommand(0.5, FloatingTextStringOnCreature("A mechanism is hidden under these stones.", oUser));
                SetLocalInt(OBJECT_SELF, "nDiscovered", 1);
            }
            else
            {
                SetLocalInt(oUser, "nIH_ar2502d_rubble", 1);
            }
        }
    }
    else if (sTag == "ar2503_fire_lever")
    {
        object oFire1 = GetNearestObjectByTag("ar2503_fire");
        if (GetIsObjectValid(oFire1))
        {
            object oFire2 = GetNearestObjectByTag("ar2503_fire", OBJECT_SELF, 2);
            object oFlamer = GetNearestObjectByTag("bw_flamer");
            object oSound = GetObjectByTag("ar2503_fire_sound");

            SoundObjectStop(oSound);
            DestroyObject(oFire1);
            DestroyObject(oFire2);
            DestroyObject(oFlamer);
            DestroyObject(oSound);
        }
    }
    else if (sTag == "ar2504_lever01")
    {
        object oDoor = GetNearestObjectByTag("ar2504_prisoner_door");
        if (GetLocked(oDoor))
        {
            SetLocked(oDoor, FALSE);
            ActionOpenDoor(oDoor);

            object oArea = GetArea(OBJECT_SELF);
            SignalEvent(oArea, EventUserDefined(501)); // prisoners freed
        }
    }

    if (FindSubString(sTag, "lever") != -1)
    {
        if (GetLocalInt(OBJECT_SELF, "nActive") == 0)
        {
            ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            SetLocalInt(OBJECT_SELF, "nActive", 1);
        }
        else
        {
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
            SetLocalInt(OBJECT_SELF, "nActive", 0);
        }
    }
}

void OpenPortal(location lLocation)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "bw_portal", lLocation, FALSE, "ar2504_portal");
}

void CreateBlockTop(location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "dag_blocktop", lLoc);
}
