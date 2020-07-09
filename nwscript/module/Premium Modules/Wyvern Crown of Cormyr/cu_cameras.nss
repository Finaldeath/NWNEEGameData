// December 2005
// B W-Husey
// Camera system - this is a basic version for simpler cutscenes (not start, jousting, etc)
// and assumes cutscenes are single player and not abortable.
// It relies heavily on a break-up and rebuild of Jon Gestalt Bye's system.
// It's much simpler because it has limited functionality.
// All camera commands are prefixed WC

//=========Declarations========================================================================


// Gets the vector linking object A to object B
vector GetVectorAB(object oA, object oB);

// Sefl explanatory!
float GetHorizontalDistanceBetween(object oA, object oB);

// Finds the compass direction from the PC to a target object
float GetDirection(object oTarget, object oPC);

//One of a pair together with below for changing the PC's camera mode
void WCCameraMode(float fDelay, object oPC, int iMode);

//Sets the camera mode for the PC
void WCCameraDoMode(string sName, int iCancel, object oPC, int iMode);

// Stops all camera movements immediately - mostly used in other functions.
    // oPC              the player whose camera movements you want to stop
    // iParty           sets whether to stop the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
    // Leave the other settings alone
void WCCameraStop(object oPC, int iParty = 0, int bAuto = TRUE, int iCamID = 0);

//Points the camera or player - usuaully used within other functions.
void WCCameraPoint(float fDirection, float fRange, float fPitch, float fdDirection, float fdRange, float fdPitch, float fd2Direction, float fd2Range, float fd2Pitch, float fCount, object oPC, int iCamID, int iFace = 0);

void WCCameraFaceTarget(object oTarget, float fRange, float fPitch, object oPC, int iFace, int iParty = 0, int iCamID = 0);

//float used within other functions
float WCCameraGetPanRate(float fDirection, float fDirection2, float fTicks, int iClockwise);

// Turns the camera and/or player between two objects = make sure both are stationary
        // fDelay           how many seconds to wait before starting the movement
        // oStart           object to face at start of movement
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt) - a high number is a shallower angle
        // oEnd             object to finish movement facing
        // fRange2          finishing distance
        // fPitch2          finishing tilt
        // fTime            number of seconds it takes camera to complete movement
        // fFrameRate       number of movements per second (governs how smooth the motion is)
        // oPC              the player whose camera you want to move
        // iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise, or 2 for auto-select
        // iFace            controls whether the camera (0), the character (2) or both (1) turn
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraFace(float fDelay, object oStart, float fRange, float fPitch, object oEnd, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iClockwise = 0, int iFace = 0, int iParty = 0);

// Moves the camera smoothly from one position to another over the specified time
        // fDelay           how many seconds to wait before starting the movement
        // fDirection       initial direction (0.0 = due east)
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt) - a high number is a shallower angle
        // fDirection2      finishing direction
        // fRange2          finishing distance
        // fPitch2          finishing tilt
        // fTime            number of seconds it takes camera to complete movement
        // fFrameRate       number of movements per second (governs how smooth the motion is)
        // oPC              the PC you want to apply the camera movement to
        // iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise, or 2 for auto-select
        // iFace            sets whether the camera (0), the character (2) or both (1) turn to face the specified direction
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraMove(float fDelay, float fDirection, float fRange, float fPitch, float fDirection2, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iClockwise = 0, int iFace = 0, int iParty = 0);

// Tracks a moving object, turning the player's camera so that it always faces towards it
        // fDelay           how many seconds to wait before starting the movement
        // oTrack           object to track the movement of
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt)
        // fRange2          finishing distance
        // fPitch2          finishing tilt
        // fTime            how long the camera will track the object for
        // fFrameRate       number of movements per second (governs how smooth the motion is)
        // oPC              the PC you want to apply the camera movement to
        // iFace            controls whether the camera (0), the character (2) or both (1) turn
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraTrack(float fDelay, object oTrack, float fRange, float fPitch, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iFace = 0, int iParty = 0);


//=====================end declarations=======================================================


// Gets the vector linking object A to object B
vector GetVectorAB(object oA, object oB)
{
    vector vA = GetPosition(oA);
    vector vB = GetPosition(oB);
    vector vDelta = (vA - vB);
    return vDelta;
}

// Finds the horizontal distance between two objects, ignoring any vertical component
float GetHorizontalDistanceBetween(object oA, object oB)
{
    vector vHorizontal = GetVectorAB(oA,oB);
    float fDistance = sqrt(pow(vHorizontal.x,2.0) + pow(vHorizontal.y,2.0));
    return fDistance;
}

// Finds the compass direction from the PC to a target object
float GetDirection(object oTarget, object oPC)
{
    vector vdTarget = GetVectorAB(oTarget,oPC);
    float fDirection = VectorToAngle(vdTarget);
    return fDirection;
}

void WCCameraDoMode(string sName, int iCancel, object oPC, int iMode)
{
    if (GetLocalInt(GetModule(),sName) >= iCancel && iCancel > 0)
        { return; }

    SetCameraMode(oPC,iMode);
}

void WCCameraMode(float fDelay, object oPC, int iMode)
{
    string sName = GetLocalString(GetModule(),"cutscene");
    int iCancel = GetLocalInt(GetModule(),sName + "time");

    DelayCommand(fDelay,WCCameraDoMode(sName,iCancel,oPC,iMode));
}

// Stops all camera movements immediately
    // oPC              the player whose camera movements you want to stop
    // iParty           sets whether to stop the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
// DO NOT CHANGE THE FOLLOWING SETTINGS!
    // bAuto            sets whether the function should stop all camera movement (TRUE) or only ones with an id lower than iCamID (FALSE)
    // iCamID           the ID of the last camera move you want to stop (this is only needed if bAuto is set to FALSE)
void WCCameraStop(object oPC, int iParty = 0, int bAuto = TRUE, int iCamID = 0)
{
    object oParty;
    string sCam;
    int iCount;

    if (iParty == 1)      { oParty = GetFirstFactionMember(oPC); }
    else if (iParty == 2) { oParty = GetFirstPC(); }
    else                  { oParty = oPC; }

    while (GetIsObjectValid(oParty))
        {
        if (bAuto)
            { iCamID = GetLocalInt(oParty,"iCamCount"); }

        iCount = iCamID;

        while (iCount > 0)
            {
            // Find the camera movement
            sCam = "iCamStop" + IntToString(iCount);
            SetLocalInt(oParty,sCam,1);
            iCount--;

            // Uncomment the line below to get a message in the game confirming each id which is cancelled
            // AssignCommand(oParty,SpeakString("Camera movement id " + IntToString(iCount) + "has been stopped"));
            }

        if (iParty == 1)                       { oParty = GetNextFactionMember(oParty,TRUE); }
        else if (iParty == 2)                  { oParty = GetNextPC(); }
        else                                   { return; }
        }
}

void WCCameraPoint(float fDirection, float fRange, float fPitch, float fdDirection, float fdRange, float fdPitch, float fd2Direction, float fd2Range, float fd2Pitch, float fCount, object oPC, int iCamID, int iFace = 0)
{
    // Check whether this camera movement has been stopped or ended
    string sCam = "iCamStop" + IntToString(iCamID);
    if (GetLocalInt(oPC,sCam) == 1)
        { return; }

    // Work out where to point the camera
    fDirection = fDirection + ((fd2Direction * pow(fCount,2.0)) / 2) + (fdDirection * fCount);
    fRange = fRange + ((fd2Range * pow(fCount,2.0)) / 2) + (fdRange * fCount);
    fPitch = fPitch + ((fd2Pitch * pow(fCount,2.0)) / 2) + (fdPitch * fCount);

    // Reset fDirectionNew if it's gone past 0 or 360 degrees
    while (fDirection < 0.0)    { fDirection = (fDirection + 360.0); }
    while (fDirection > 360.0)  { fDirection = (fDirection - 360.0); }

    // Set the camera and/or player facing, according to iFace
    if (iFace < 2)        { AssignCommand(oPC,SetCameraFacing(fDirection,fRange,fPitch)); }
    if (iFace > 0)        { AssignCommand(oPC,SetFacing(fDirection)); }

    // Store the current position of the camera
    SetLocalFloat(oPC,"fCameraDirection",fDirection);
    SetLocalFloat(oPC,"fCameraRange",fRange);
    SetLocalFloat(oPC,"fCameraPitch",fPitch);
}


void WCCameraFaceTarget(object oTarget, float fRange, float fPitch, object oPC, int iFace, int iParty = 0, int iCamID = 0)
{
    // Check whether this camera movement has been stopped
    string sCam = "iCamStop" + IntToString(iCamID);
    if (iCamID > 0 && GetLocalInt(oPC,sCam) == 1)
        { return; }

    float fDirection;
    object oParty;

    if (iParty == 1)      { oParty = GetFirstFactionMember(oPC); }
    else if (iParty == 2) { oParty = GetFirstPC(); }
    else                  { oParty = oPC; }

    while (GetIsObjectValid(oParty))
        {
        fDirection = GetDirection(oTarget,oParty);

        if (iFace < 2)        { AssignCommand(oParty,SetCameraFacing(fDirection,fRange,fPitch)); }
        if (iFace > 0)        { AssignCommand(oParty,SetFacing(fDirection)); }

        // Store the current position of the camera
        SetLocalFloat(oParty,"fCameraDirection",fDirection);
        SetLocalFloat(oParty,"fCameraRange",fRange);
        SetLocalFloat(oParty,"fCameraPitch",fPitch);

        if (iParty == 1)                       { oParty = GetNextFactionMember(oParty,TRUE); }
        else if (iParty == 2)                  { oParty = GetNextPC(); }
        else                                   { return; }
        }
}



float WCCameraGetPanRate(float fDirection, float fDirection2, float fTicks, int iClockwise)
{
    // Calculates how far the camera needs to move each to tick to go from fDirection to fDirection2
    // in fTicks steps, correcting as necessary to account for clockwise or anti-clockwise movement

    float fdDirection;

    if (iClockwise == 0)
        {
        if (fDirection > fDirection2)               { fdDirection = ((fDirection2 + 360.0 - fDirection) / fTicks); }
        else                                        { fdDirection = ((fDirection2 - fDirection) / fTicks); }
        }

    if (iClockwise == 1)
        {
        if (fDirection2 > fDirection)               { fdDirection = ((fDirection2 - fDirection - 360.0) / fTicks); }
        else                                        { fdDirection = ((fDirection2 - fDirection) / fTicks); }
        }

    if (iClockwise == 2)
        {
        float fCheck = fDirection2 - fDirection;
        if (fCheck > 180.0)                         { fdDirection = ((fDirection2 - fDirection - 360.0) / fTicks); }
        else if (fCheck < -180.0)                   { fdDirection = ((fDirection2 + 360.0 - fDirection) / fTicks); }
        else                                        { fdDirection = ((fDirection2 - fDirection) / fTicks); }
        }

    return fdDirection;
}


// Moves the camera smoothly from one position to another over the specified time
    // STARTING TIME -
        // fDelay           how many seconds to wait before starting the movement
    // STARTING CONDITIONS -
        // fDirection       initial direction (0.0 = due east)
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt)
    // FINAL CONDITIONS -
        // fDirection2      finishing direction
        // fRange2          finishing distance
        // fPitch2          finishing tilt
    // TIME SETTINGS -
        // fTime            number of seconds it takes camera to complete movement
        // fFrameRate       number of movements per second (governs how smooth the motion is)
    // MISC SETTINGS -
        // oPC              the PC you want to apply the camera movement to
        // iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise, or 2 for auto-select
        // iFace            sets whether the camera (0), the character (2) or both (1) turn to face the specified direction
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraMove(float fDelay, float fDirection, float fRange, float fPitch, float fDirection2, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iClockwise = 0, int iFace = 0, int iParty = 0)
{
    // Get timing information
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);
    float fStart = fDelay;
    float fCount;

    float fdDirection = WCCameraGetPanRate(fDirection,fDirection2,fTicks,iClockwise);
    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);

    int iCamID;
    object oParty;

    if (iParty == 1)      { oParty = GetFirstFactionMember(oPC); }
    else if (iParty == 2) { oParty = GetFirstPC(); }
    else                  { oParty = oPC; }

    while (GetIsObjectValid(oParty))
        {
        // Set the camera to top down mode
        WCCameraMode(fDelay,oParty,CAMERA_MODE_TOP_DOWN);

        // Give the camera movement a unique id code so that it can be stopped
        iCamID = GetLocalInt(oParty,"iCamCount") + 1;
        SetLocalInt(oParty,"iCamCount",iCamID);

        // reset variables
        fCount = 0.0;
        fDelay = fStart;

        // Uncomment the line below to get a message in the game telling you the id of this camera movement
        // AssignCommand(oParty,SpeakString("Camera id - " + IntToString(iCamID)));

        // After delay, stop any older camera movements and start this one
        DelayCommand(fStart,WCCameraStop(oParty,0,FALSE,iCamID - 1));

        while (fCount <= fTicks)
            {
            DelayCommand(fDelay,WCCameraPoint(fDirection,fRange,fPitch,fdDirection,fdRange,fdPitch,0.0,0.0,0.0,fCount,oParty,iCamID,iFace));
            fCount = (fCount + 1.0);
            fDelay = fStart + (fCount * fdTime);
            }

        if (iParty == 1)                       { oParty = GetNextFactionMember(oParty,TRUE); }
        else if (iParty == 2)                  { oParty = GetNextPC(); }
        else                                   { return; }
        }
}

// Turns the camera and/or player between two objects
// NOTE that this will only work properly if the player and target objects are stationary while the function is active
    // STARTING TIME -
        // fDelay           how many seconds to wait before starting the movement
    // STARTING CONDITIONS -
        // oStart           object to face at start of movement
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt)
    // FINAL CONDITIONS -
        // oEnd             object to finish movement facing
        // fRange2          finishing distance
        // fPitch2          finishing tilt
    // TIME SETTINGS -
        // fTime            number of seconds it takes camera to complete movement
        // fFrameRate       number of movements per second (governs how smooth the motion is)
    // MISC SETTINGS -
        // oPC              the player whose camera you want to move
        // iClockwise       set to 1 if you want the camera to rotate clockwise, 0 for anti-clockwise, or 2 for auto-select
        // iFace            controls whether the camera (0), the character (2) or both (1) turn
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraFace(float fDelay, object oStart, float fRange, float fPitch, object oEnd, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iClockwise = 0, int iFace = 0, int iParty = 0)
{
    // Get timing information
    float fCount = 0.0;
    float fStart = fDelay;
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);

    float fDirection;
    float fDirection2;

    float fdDirection;
    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);

    object oParty;
    int iCamID;

    // Get first player
    if (iParty == 1)      { oParty = GetFirstFactionMember(oPC); }
    else if (iParty == 2) { oParty = GetFirstPC(); }
    else                  { oParty = oPC; }

    while (GetIsObjectValid(oParty))
        {
        // Set the camera to top down mode
        WCCameraMode(fDelay,oParty,CAMERA_MODE_TOP_DOWN);

        // Give the camera movement a unique id code so that it can be stopped
        iCamID = GetLocalInt(oParty,"iCamCount") + 1;
        SetLocalInt(oParty,"iCamCount",iCamID);

        // reset variables
        fCount = 0.0;
        fDelay = fStart;

        // Work out rotation rate for this player
        fDirection = GetDirection(oStart,oParty);
        fDirection2 = GetDirection(oEnd,oParty);
        fdDirection = WCCameraGetPanRate(fDirection,fDirection2,fTicks,iClockwise);

        // After delay, stop any older camera movements and start this one
        DelayCommand(fStart,WCCameraStop(oParty,0,FALSE,iCamID - 1));

        while (fCount <= fTicks)
            {
            DelayCommand(fDelay,WCCameraPoint(fDirection,fRange,fPitch,fdDirection,fdRange,fdPitch,0.0,0.0,0.0,fCount,oParty,iCamID,iFace));
            fCount = (fCount + 1.0);
            fDelay = fStart + (fCount * fdTime);
            }

        if (iParty == 1)                       { oParty = GetNextFactionMember(oParty,TRUE); }
        else if (iParty == 2)                  { oParty = GetNextPC(); }
        else                                   { return; }
        }
}




// Tracks a moving object, turning the player's camera so that it always faces towards it
    // STARTING TIME -
        // fDelay           how many seconds to wait before starting the movement
    // TARGET -
        // oTrack           object to track the movement of
    // STARTING CONDITIONS -
        // fRange           initial distance between player and camera
        // fPitch           initial pitch (vertical tilt)
    // FINAL CONDITIONS -
        // fRange2          finishing distance
        // fPitch2          finishing tilt
    // TIME SETTINGS -
        // fTime            how long the camera will track the object for
        // fFrameRate       number of movements per second (governs how smooth the motion is)
    // MISC SETTINGS -
        // oPC              the PC you want to apply the camera movement to
        // iFace            controls whether the camera (0), the character (2) or both (1) turn
        // iParty           sets whether to move the camera of only oPC (0), all the players in oPC's party (1) or all the players on the server (2)
void WCCameraTrack(float fDelay, object oTrack, float fRange, float fPitch, float fRange2, float fPitch2, float fTime, float fFrameRate, object oPC, int iFace = 0, int iParty = 0)
{
    // Get timing information
    float fCount;
    float fStart = fDelay;
    float fTicks = (fTime * fFrameRate);
    float fdTime = (fTime / fTicks);

    float fSRange = fRange;
    float fSPitch = fPitch;

    float fdRange = ((fRange2 - fRange) / fTicks);
    float fdPitch = ((fPitch2 - fPitch) / fTicks);

    object oParty;
    int iCamID;

    if (iParty == 1)      { oParty = GetFirstFactionMember(oPC); }
    else if (iParty == 2) { oParty = GetFirstPC(); }
    else                  { oParty = oPC; }

    while (GetIsObjectValid(oParty))
        {
        // Set the camera to top down mode
        WCCameraMode(fDelay,oParty,CAMERA_MODE_TOP_DOWN);

        // Give the camera movement a unique id code so that it can be stopped
        iCamID = GetLocalInt(oParty,"iCamCount") + 1;
        SetLocalInt(oParty,"iCamCount",iCamID);

        // reset variables
        fCount = 0.0;
        fDelay = fStart;
        fRange = fSRange;
        fPitch = fSPitch;

        // After delay, stop any older camera movements and start this one
        DelayCommand(fStart,WCCameraStop(oParty,0,FALSE,iCamID - 1));

        while (fCount <= fTicks)
            {
            DelayCommand(fDelay,WCCameraFaceTarget(oTrack,fRange,fPitch,oParty,iFace,0,iCamID));
            fPitch = (fPitch + fdPitch);
            fRange = (fRange + fdRange);
            fCount = (fCount + 1.0);
            fDelay = fStart + (fCount * fdTime);
            }

        if (iParty == 1)                       { oParty = GetNextFactionMember(oParty,TRUE); }
        else if (iParty == 2)                  { oParty = GetNextPC(); }
        else                                   { return; }
        }
}


