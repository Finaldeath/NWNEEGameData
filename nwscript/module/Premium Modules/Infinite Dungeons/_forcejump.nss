//::///////////////////////////////////////////////
//:: forcejump
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Script executed on an object, that absolutely
    makes sure it jumps to its target (within
    5 meters, unless overriden).

    Variables to set on target
    location: PC_JUMP_LOCATION_INC_GENERIC
    range: PC_JUMP_RANGE_INC_GENERIC
             - if not set, defaults to 5.0
               cannot be lower than 0.1
    associate jump: PC_JUMP_MOVE_ASSOCIATES
      - if TRUE, will also attempt to jump all associates of the PC
    camera settings: PC_JUMP_CAMERA_SETTINGS
      - if TRUE, applies ALL the following variables, whether they've
        been set or not. So it's safest to set them all.
          - PC_JUMP_CAMERA_DIRECTION
          - PC_JUMP_CAMERA_DISTANCE
          - PC_JUMP_CAMERA_PITCH
          - PC_JUMP_CAMERA_HEIGHT
          - PC_JUMP_CAMERA_MOVEMENT_RATE
    Constants defined in _inc_generic.nss
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: May 4, 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

const float RANGE_DEFAULT = 5.0;
const float RANGE_MIN = 0.1;
const int MAX_ATTEMPTS = 8;

void CleanUp();
void JumpAssociate(object oAssociate, location lLoc);

void main()
{
    location lTarget = GetLocalLocation(OBJECT_SELF, PC_JUMP_LOCATION_INC_GENERIC);
    float fRange = GetLocalFloat(OBJECT_SELF, PC_JUMP_RANGE_INC_GENERIC);
    if(fRange < RANGE_MIN) fRange = RANGE_DEFAULT;

    if(GetCutsceneMode() && !GetLocalInt(OBJECT_SELF, PC_JUMP_CUTSCENE_OK))
    {
        // Don't even attempt to jump a player who is in cutscene mode. Could do
        // funky things if this is done. Instead, jump the player as soon as he
        // is no longer in a cutscene.
        // Update: Added a condition where if a variable is set, it is ok
        // to jump the player during cutscene mode.
        DelayCommand(1.0, ExecuteScript(FORCE_JUMP_SCRIPT_INC_GENERIC, OBJECT_SELF));
        return;
    }

    object oTargetArea = GetAreaFromLocation(lTarget);
    // Condition 1: Is the area part of the location valid? If not, it could be
    //   that due to a certain sequence of events, the target location has
    //   already been deleted. Therefore, we have to stop now.
    // Condition 2: If the current area is different than the target area, jump.
    // Condition 3: If the current area is the same as the target area, we can
    //   then check for the distance. If we're still too far, jump.
    if( GetIsObjectValid(oTargetArea) &&
          ((GetArea(OBJECT_SELF) != oTargetArea) ||
          (GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lTarget) > fRange)) )
    {
        location lCurrentLocation = GetLocation(OBJECT_SELF);
        int nNumAttempts = GetLocalInt(OBJECT_SELF, PC_JUMP_NUM_ATTEMPTS);

        // Is the PC's location even valid? If not, they might be transitioning.
        // Jump attempts in this case are not counted.
        if(GetIsObjectValid(GetAreaFromLocation(lCurrentLocation)))
        {
            // Has the PC moved?
            location lOldLocation = GetLocalLocation(OBJECT_SELF, PC_JUMP_OLD_LOCATION);
            if(GetDistanceBetweenLocations(lCurrentLocation, lOldLocation) < 0.2)
            {
                // if not, increase the attempt number. We later check
                // this number to see if we should bother firing the script
                // again.
                nNumAttempts++;
            }
            // store current location
            SetLocalLocation(OBJECT_SELF, PC_JUMP_OLD_LOCATION, GetLocation(OBJECT_SELF));
            SetLocalInt(OBJECT_SELF, PC_JUMP_NUM_ATTEMPTS, nNumAttempts);
        }

        // jump associates, if variable is set
        if(GetLocalInt(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES))
        {
            // set the position offset angle to be behind the PC
            SetLocalFloat(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES_OFFSET_ANGLE, GetFacingFromLocation(lTarget)+180.0);

            JumpAssociate(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION), lTarget);
            JumpAssociate(GetAssociate(ASSOCIATE_TYPE_DOMINATED), lTarget);
            JumpAssociate(GetAssociate(ASSOCIATE_TYPE_FAMILIAR), lTarget);
            JumpAssociate(GetAssociate(ASSOCIATE_TYPE_SUMMONED), lTarget);
            int i = 1;
            object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF, 1);
            while(GetIsObjectValid(oHench))
            {
                JumpAssociate(oHench, lTarget);
                i++;
                oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, OBJECT_SELF, i);
            }
        }

        // jump PC
        ClearAllActions(TRUE);
        ActionJumpToLocation(lTarget);
        if(GetLocalInt(OBJECT_SELF, PC_JUMP_CAMERA_SETTINGS))
        {
            // if this variable is set, we want to apply some camera settings as well
            float fDirection = GetLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_DIRECTION);
            float fDistance = GetLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_DISTANCE);
            float fPitch = GetLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_PITCH);
            SetCameraFacing(fDirection, fDistance, fPitch);
            SetCameraHeight(OBJECT_SELF, GetLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_HEIGHT));
            SetCutsceneCameraMoveRate(OBJECT_SELF, GetLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_MOVEMENT_RATE));
        }

        // if we haven't run out of failed attempts (that haven't failed due
        // to legitimate reasons), then try again. Otherwise, give up.
        if(nNumAttempts < MAX_ATTEMPTS)
        {
            DelayCommand(0.5, ExecuteScript(FORCE_JUMP_SCRIPT_INC_GENERIC, OBJECT_SELF));
        }
        else
        {
            // since we're not trying anymore, cleanup the variables
            CleanUp();
        }
    }
    else
    {
        // the pc is within range of the target. delete variables on pc
        CleanUp();
    }
}

void CleanUp()
{
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_DIRECTION);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_DISTANCE);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_HEIGHT);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_MOVEMENT_RATE);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_CAMERA_PITCH);
    DeleteLocalInt(OBJECT_SELF, PC_JUMP_CAMERA_SETTINGS);
    DeleteLocalInt(OBJECT_SELF, PC_JUMP_CUTSCENE_OK);
    DeleteLocalLocation(OBJECT_SELF, PC_JUMP_LOCATION_INC_GENERIC);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_RANGE_INC_GENERIC);
    DeleteLocalLocation(OBJECT_SELF, PC_JUMP_OLD_LOCATION);
    DeleteLocalInt(OBJECT_SELF, PC_JUMP_NUM_ATTEMPTS);
    DeleteLocalInt(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES);
    DeleteLocalFloat(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES_OFFSET_ANGLE);
}

void JumpAssociate(object oAssociate, location lLoc)
{
    if(GetIsObjectValid(oAssociate))
    {
        vector vLoc = GetPositionFromLocation(lLoc);
        // get the offset angle
        float fAngle = GetLocalFloat(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES_OFFSET_ANGLE);
        // move it for next valid associate
        SetLocalFloat(OBJECT_SELF, PC_JUMP_MOVE_ASSOCIATES_OFFSET_ANGLE, fAngle + 35.0);

        // adjust position by a meter in desired angle
        vLoc.x += cos(fAngle);
        vLoc.y += sin(fAngle);

        location lNewLoc = Location(GetAreaFromLocation(lLoc), vLoc, GetFacingFromLocation(lLoc));

        AssignCommand(oAssociate, ClearAllActions(TRUE));
        AssignCommand(oAssociate, ActionJumpToLocation(lNewLoc));
    }
}
