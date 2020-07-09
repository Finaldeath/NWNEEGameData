//:://////////////////////////////////////////////////
//:: c2_oe_am_worldmap
/*
  OnEnter script for world map area.

  This script will set up the world map area as it
  is intended to be viewed.

  Player and associates will be turned invisible,
  footfalls will be silenced,
  camera will be reoriented and fixed.

*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2005 Bioware Corp.
//:: Created By: Brian Watson for Ossian Studios
//:: Created On: 4/3/2006
//:://////////////////////////////////////////////////

#include "hf_in_worldmap"

void main()
{
    object oEnterer = GetEnteringObject();
    object oWP = GetObjectByTag("wmp_mapcenter");
    effect eFreeze = EffectCutsceneImmobilize();
    effect eGhost = EffectCutsceneGhost();

    // set up character for this area
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oEnterer);
    MapVanish(oEnterer);

    // for PC's only
    if (GetIsPC(oEnterer))
    {
        // boost the character's speed
        // -- don't need to do this if we use the onclick event!
        // effect eSpeed = EffectMovementSpeedIncrease(99);
        // eSpeed = SupernaturalEffect(eSpeed);
        // ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oEnterer);

        // make the area the pc was just in visible
        // useful for debugging and testing, although
        // probably not needed in actual game
        SetLocalInt(OBJECT_SELF, "iHeartbeat", 1);
        ExecuteScript("rb_map_phb", OBJECT_SELF);

        int i = 1;

        object oHostile = oEnterer;

        while(oHostile != OBJECT_INVALID)
        {
            oHostile = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                          REPUTATION_TYPE_ENEMY,
                                          oEnterer,
                                          i);

            if(GetIsObjectValid(oHostile) &&
               GetAssociateType(oHostile) == ASSOCIATE_TYPE_NONE)
            {
               DestroyObject(oHostile);
            }

            i++;
        }

        string sLastArea = GetStringLowerCase(GetLocalString(oEnterer, "sWM_PreviousArea"));
        object oModule = GetModule();
        string sVariableName = ("nWM_" + sLastArea + "_status");
        int nAreaStatus = GetLocalInt(oModule, sVariableName);

        if (nAreaStatus != nWM_VISIBLE)
        {
            SetLocalInt(oModule, sVariableName, nWM_VISIBLE);
        }

        // create map pin
        PlaceMapPin(oEnterer);

        // and update world map
        DelayCommand(0.8f, UpdateWorldMap(oEnterer));

        // set up the camera
        BlackScreen(oEnterer);
        AssignCommand(oEnterer, ClearAllActions());
        AssignCommand(oEnterer, ActionJumpToObject(oWP));
        AssignCommand(oEnterer, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oEnterer)));
        AssignCommand(oEnterer, ActionDoCommand(SetCutsceneMode(oEnterer, TRUE, TRUE)));
        AssignCommand(oEnterer, ActionDoCommand(SetCameraMode(oEnterer, CAMERA_MODE_TOP_DOWN)));
        AssignCommand(oEnterer, ActionWait(1.0f));
        AssignCommand(oEnterer, ActionDoCommand(SetCameraFacing(90.0f, 17.7f, 1.0f)));
        AssignCommand(oEnterer, ActionDoCommand(FadeFromBlack(oEnterer, FADE_SPEED_FAST)));

        // DEBUG!!!
        /*
        if (GetLocalInt(oEnterer, "nWM_UsedInventoryMap") == 1)
        {
            DelayCommand(3.0f, FloatingTextStringOnCreature("In Inventory Map!", oEnterer));
        }
        */
    }
    else
    {
        // this must be an associate creature
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oEnterer);
        AssignCommand(oEnterer, ClearAllActions());
        AssignCommand(oEnterer, ActionJumpToObject(oWP));
    }
}
