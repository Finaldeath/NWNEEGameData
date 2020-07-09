
const int CRAWL = CAMERA_TRANSITION_TYPE_CRAWL;
const int FAST = CAMERA_TRANSITION_TYPE_FAST;
const int MEDIUM = CAMERA_TRANSITION_TYPE_MEDIUM;
const int SLOW = CAMERA_TRANSITION_TYPE_SLOW;
const int SNAP = CAMERA_TRANSITION_TYPE_SNAP;
const int VERY_FAST = CAMERA_TRANSITION_TYPE_VERY_FAST;
const int VERY_SLOW = CAMERA_TRANSITION_TYPE_VERY_SLOW;

const int WALK = 0;
const int RUN = 1;
const int JUMP = 2;

const int CLOCKWISE = -1;
const int COUNTERCLOCKWISE = 1;

// Removes all effects from Target created by objects with the Tag: Creator.
void RemoveEffectByCreator(object Target,object Creator);

// Found in cutscene
// Returns angle between Two and One.  Two defaults to GetFirstPC().
float GetAngle(object One, object Two = OBJECT_INVALID);

// Found in cutscene
// Returns distance between Target and GetFirstPC().
float GetDist(object oCreature, object Target);

// Found in cutscene
// Starts cutscene mode and sets initial camera position.
void StartCutscene(object oPC, float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int CSNumber = -1, int TransType = SNAP);

// Found in cutscene
// Ends cutscene mode and sets final camera position.
void EndCutscene(float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = FAST);

// Found in cutscene
// Shortcut for SetCameraFacing() command.
void Pan(float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = SLOW);

// Found in cutscene
// Forces camera to track Target as long as SetTracking() == TRUE.
void Track(object Target, float Dist = 10.0, float Pitch = 50.0, float Delay=0.05);

// Found in cutscene
// Forces camera to track Target with GetDistance + Adjustment for range as long as SetTracking() == TRUE.
void TrackWithRange(object Target,float Adjustment = 4.0,float Pitch = 50.0,float Delay=0.05);

// Found in cutscene
// Sets whether or not to Track a target or Panorama.
void SetTracking(int TF=TRUE);

// Found in cutscene
// Camera circles at constant rate until SetTracking() == FALSE.
void Panorama(float Angle, float Step = 1.0, float Dist = 10.0, float Pitch = 70.0, float Delay = 0.04);

// Found in cutscene
// Camera circles Count times. Return value is number of seconds to complete circles.
void Circle(float Angle, float Step = 1.0, float Dist = 10.0, float Pitch = 70.0, float Delay = 0.04, float Count = 1.0);

// Found in cutscene
// Proxy GetFirstPC for cutscene
object CutscenePC();

// Found in cutscene
// Pan() that use GetFirstPC() action queue
// Cameraman moves to Loc by either WALK, RUN, ot JUMP Speed.
void CameramanPan(location Loc, int Speed = WALK, float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = SLOW);

// Found in cutscene
// Sets up CutscenePC() and camera effects on GetFirstPC().
// Center is the place where CutscenePC is placed. GetFirstPC() is deafult.
void StartCameraman(object Center = OBJECT_INVALID, object oPlayer = OBJECT_INVALID);

// Found in cutscene
// Undoes StartCameraman()
void EndCameraman(object oPlayer = OBJECT_INVALID);

// Found in cutscene
// Returns the angle at which Tag is facing
float GetFacingByTag(string Tag);

// Found in cutscene
// Stores last camera position during a cutscene.
void SetLastCameraPosition(float Angle, float Dist, float Pitch);

// Found in cutscene
// Uses action queue to keep timing on Pans.  Pans from LastCameraPosition.
void ActionControlledPan(float Angle, float Dist, float Pitch, float Time,int Dir = CLOCKWISE);
//**************************************************************************************************************
//**************************************************************************************************************
//**************************************************************************************************************

float GetAngle(object One, object Two = OBJECT_INVALID)
    {
    if (!GetIsObjectValid(Two))
        Two = GetFirstPC();
    return VectorToAngle(GetPosition(One)-GetPosition(Two));
    }

float GetDist(object oCreature, object Target)
    {
    float Return = GetDistanceBetween(oCreature,Target)+1;
    if (Return <5.0)
        Return = 5.0;
    else if (Return > 20.0)
        Return = 20.0;
    return Return;
    }

void StartCutscene(object oPC, float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int CSNumber = -1, int TransType = SNAP)
    {
    SetCutsceneMode(oPC,TRUE);
    SetCameraMode(oPC,CAMERA_MODE_TOP_DOWN);
    DelayCommand(0.2,AssignCommand(oPC,SetCameraFacing(Angle,Dist,Pitch,TransType)));
    DelayCommand(0.3,AssignCommand(oPC,SetCameraFacing(Angle,Dist,Pitch,TransType)));
    DelayCommand(0.4,AssignCommand(oPC,SetCameraFacing(Angle,Dist,Pitch,TransType)));
    SetLastCameraPosition(Angle,Dist,Pitch);
    }

void EndCutscene(float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = FAST)
    {
    if (GetIsObjectValid(CutscenePC()))
        EndCameraman();
    AssignCommand(GetFirstPC(),StoreCameraFacing());
    AssignCommand(GetFirstPC(),SetCutsceneMode(GetFirstPC(),FALSE));
    AssignCommand(GetFirstPC(),RestoreCameraFacing());
    AssignCommand(GetFirstPC(),SetCameraFacing(Angle,Dist,Pitch,TransType));
    }

void Pan(float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = SLOW)
    {
    AssignCommand(GetFirstPC(),SetCameraFacing(Angle,Dist,Pitch,TransType));
    SetLastCameraPosition(Angle,Dist,Pitch);
    }

void Track(object Target, float Dist = 10.0, float Pitch = 50.0, float Delay=0.05)
    {
    if (GetLocalInt(GetFirstPC(),"Tracking"))
        {
        Pan(GetAngle(Target),Dist,Pitch,SNAP);
        DelayCommand(Delay,Track(Target,Dist,Pitch,Delay));
        }
    }

void TrackWithRange(object Target,float Adjustment = 4.0,float Pitch = 50.0,float Delay=0.05)
    {
    if (GetLocalInt(GetFirstPC(),"Tracking"))
        {
        Pan(GetAngle(Target),GetDist(GetFirstPC(),Target)+Adjustment,Pitch,SNAP);
        DelayCommand(Delay,Track(Target,Adjustment,Pitch,Delay));
        }
    }

void SetTracking(int TF=TRUE)
    {
    SetLocalInt(GetFirstPC(),"Tracking",TF);
    }

void Panorama(float Angle, float Step = 1.0, float Dist = 10.0, float Pitch = 70.0, float Delay = 0.04)
    {
    if (GetLocalInt(GetFirstPC(),"Tracking"))
        {
        if (Angle < 0.0)
            Angle += 360.0;
        if (Angle >360.0)
            Angle -= 360.0;
        Pan(Angle, Dist, Pitch, SNAP);
        DelayCommand(Delay,Panorama(Angle+Step,Step,Dist,Pitch,Delay));
        }
    }

void Circle(float Angle, float Step = 1.0, float Dist = 10.0, float Pitch = 70.0, float Delay = 0.04, float Count = 1.0)
    {
    float Adjust = 0.0;
    int Finish = abs(FloatToInt((360.0 * Count) / Step));
    float NewDelay = 0.0;
    int x;
    for (x=1;x<=Finish;x++)
        {
        Adjust += Step;
        DelayCommand(NewDelay,Pan(Angle+Adjust,Dist, Pitch, SNAP));
        NewDelay += Delay;
        }
    }

object CutscenePC()
    {
    return (GetObjectByTag("CSPC"));
    }

void StartCameraman(object Center = OBJECT_INVALID, object oPlayer = OBJECT_INVALID)
    {
    if (!GetIsObjectValid(oPlayer))
       oPlayer = GetFirstPC();
    if (!GetIsObjectValid(Center))
        Center = oPlayer;

    object New = CopyObject(oPlayer,GetLocation(Center),OBJECT_INVALID,"CSPC");
    DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),New,0.5));
    DelayCommand(0.61,AssignCommand(CutscenePC(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),GetFirstPC())));
    AssignCommand(CutscenePC(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneGhost(),oPlayer));
    }

void EndCameraman(object oPlayer = OBJECT_INVALID)
    {
    if (!GetIsObjectValid(oPlayer))
      oPlayer = GetFirstPC();
    //AssignCommand(GetFirstPC(),JumpToLocation(GetLocation(CutscenePC())));
    AssignCommand(oPlayer,SetFacing(GetFacing(CutscenePC())));
    RemoveEffectByCreator(oPlayer,CutscenePC());
    DelayCommand(0.1,AssignCommand(CutscenePC(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),OBJECT_SELF)));
    DestroyObject(CutscenePC(),0.2);
    }

void CameramanPan(location Loc, int Speed = WALK, float Angle = -1.0, float Dist = -1.0, float Pitch = 50.0, int TransType = SLOW)
    {
    AssignCommand(GetFirstPC(),ActionDoCommand(Pan(Angle,Dist,Pitch,TransType)));
    if (Speed == JUMP)
    AssignCommand(GetFirstPC(),ActionJumpToLocation(Loc));
        else
    AssignCommand(GetFirstPC(),ActionMoveToLocation(Loc,Speed));
    }

float GetFacingByTag(string Tag)
    {
    return GetFacing(GetObjectByTag(Tag));
    }

void SetLastCameraPosition(float Angle, float Dist, float Pitch)
    {
    SetLocalFloat(GetFirstPC(),"CameraAngle",Angle);
    SetLocalFloat(GetFirstPC(),"CameraDist",Dist);
    SetLocalFloat(GetFirstPC(),"CameraPitch",Pitch);
    }

void ActionControlledPan2(float Angle, float Dist, float Pitch, float Time,int Dir = CLOCKWISE)
    {
    int Steps = FloatToInt(Time/0.02);
    float StartAngle = GetLocalFloat(GetFirstPC(),"CameraAngle");
    float StartDist = GetLocalFloat(GetFirstPC(),"CameraDist");
    float StartPitch = GetLocalFloat(GetFirstPC(),"CameraPitch");
    float TempAngle1 = (Angle - StartAngle)/Steps;
    if (Dir == CLOCKWISE && Angle > StartAngle)
        TempAngle1 = ((Angle - StartAngle)-360.0)/Steps;
    else if (Dir == COUNTERCLOCKWISE && Angle < StartAngle)
        TempAngle1 = (360.0 + (Angle - StartAngle))/Steps;
    float TempDist1 = (Dist - StartDist)/Steps;
    float TempPitch1 = (Pitch - StartPitch)/Steps;
    float TempAngle2, TempDist2, TempPitch2;
    int x;
    for (x=1;x<=Steps;x++)
        {
        TempAngle2 = StartAngle + x*TempAngle1;
        TempDist2 = StartDist + x*TempDist1;
        TempPitch2 = StartPitch + x*TempPitch1;
//        DelayCommand(0.02*x,Pan(TempAngle2,TempDist2,TempPitch2,SNAP,CutsceneSub));
        DelayCommand(0.02*x,Pan(TempAngle2,TempDist2,TempPitch2,SNAP));
        }
    }

void ActionControlledPan(float Angle, float Dist, float Pitch, float Time,int Dir = CLOCKWISE)
    {
    ActionDoCommand(ActionControlledPan2(Angle, Dist, Pitch, Time, Dir));
    ActionWait(Time);
    ActionDoCommand(SetLastCameraPosition(Angle, Dist, Pitch));
    }

void RemoveEffectByCreator(object Target,object Creator)
    {
    effect eFect = GetFirstEffect(Target);
    while(GetIsEffectValid(eFect))
        {
        if (GetEffectCreator(eFect) == Creator)
            {
            //Debug("Removed "+GetName(Target)+" "+GetName(GetEffectCreator(eFect)));
            RemoveEffect(Target,eFect);
            }
        eFect = GetNextEffect(Target);
        }
    }

//Gale: Gets the first player on server. (not DM)
object GetFirstPCNonDMPC()
{
   object oPC = GetFirstPC();
   do
     if (!GetIsDM(oPC))
       return oPC;
   while (GetIsObjectValid(oPC = GetNextPC()));

   return OBJECT_INVALID;
}
//void main(){}
