//::////////////////////////////////////////////////////////////////////////////
//:: inc_debug
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Debug Functions and constants. Provides debug override functions for:
    GetObjectByTag
    GetNearestObjectByTag
    CreateObject
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 19, 2005
//::////////////////////////////////////////////////////////////////////////////


#include "x0_i0_position"


// void main() {}



/*------------------------------------------------------------------------------
    DEBUG CONSTANTS
------------------------------------------------------------------------------*/



// Set TRUE for debugging information false otherwise.
const int DEBUG_MODE = TRUE;

// Set TRUE to have debugging information recorded in a time stamped log entry.
const int LOG_ENTRY = TRUE;

// Set TRUE to have debugging information messaged to the first PC.
const int PLAYER_MESSAGE = FALSE;



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Debug Message
//
// Defined in: inc_debug
//
// Presents a the message sMessage to the first player character, as determined
// by GetFirstPC(), and prints it to the log file if debug mode is enabled.
//
// Parameters:
// sMsg - The debug message to be displayed.
//
// Return:
// NONE
void DebugMessage(string sMsg);

// Name: Debug Get Object By Tag
//
// Defined in: inc_debug
//
// Wrapper function for GetObjectByTag. This function provides debug information
// including the method call and parameters when a call to GetObjectByTag
// returns OBJECT_INVALID.
//
// Parameters:
// sTag - The tag of the object to be retreived.
// nNth - The nth object of tag sTag may be requested.
//
// Return:
// NONE
object DB_GetObjectByTag(string sTag, int nNth = 0);

// Name: Debug Get Nearest Object By Tag
//
// Defined in: inc_debug
//
// Wrapper function for GetNearestObjectByTag. This function will provide
// feedback when a call to get nearest object returns OBJECT_INVALID in the
// form of a debug message providing the tag of the object that was being
// retrieved and the tag of the calling object. Note that this funciton will
// still return OBJECT_INVALID if that is what is retreived.
//
// Parameters:
// sTag    - The tag of the object to retreive.
// oTarget - The target object; the nearest object of sTag to this target should
//           be retreived.
// nNth    - Retreives the nNth nearest object with tag sTag.
//
// Return:
// The object retreived or OBJECT_INVALID on error.
object DB_GetNearestObjectByTag(string sTag, object oTarget = OBJECT_SELF, int nNth = 1);

// Name: Debug Get Waypoint By Tag
//
// Defined in: inc_debug
//
// Wrapper function for GetWaypointByTag. Delivers feedback in the form of a
// message to the player if the waypoint retreived is invalid.
//
// Parameters:
// sWaypointTag - The tag og the waypoint to be retreived.
//
// Return:
// The waypoint OR OBJECT_INVALID if the waypoint cannot be found.
object DB_GetWaypointByTag(string sWaypointTag);

// Name: Debug Create Object
//
// Defined in: inc_debug
//
// Wrapper function for CreateObject that delivers feedback in the form of a
// message to the first player (as returned by GetFirstPC) containing all of the
// parameters of the function call.
//
// Parameters:
// nObjectType - The type of object to be created, one of: OBJECT_TYPE_ITEM,
//               OBJECT_TYPE_CREATURE, OBJECT_TYPE_PLACEABLE, OBJECT_TYPE_STORE,
//               OBJECT_TYPE_WAYPOINT.
// sTemplate   - The object's ResRef.
// lLocation   - The location at which the object will be created.
// bUseAppearAnimation - If this is TRUE the object will appear with an
//               associated animation.
// sNewTag     - The object will be created with this tag, if this argument is
//               empty the object's default tag is used.
//
// Return:
// NONE
object DB_CreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "");



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: DebugMessage
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 19, 2005
//::////////////////////////////////////////////////////////////////////////////
void DebugMessage(string sMsg)
{
    // If debug mode is enabled send the message otherwise do nothing.
    if (DEBUG_MODE)
    {
        // Activating player messages can destroy loops with GetFirstPC()
        // and GetNextPC() calls if the debug message is called within the loop.
        // This part of the DebugMessage should potentially be removed entirely
        // or at the very least only allowed in single player mode.
        if (PLAYER_MESSAGE)
        {
            object oPC = GetFirstPC();
            SendMessageToPC(oPC, sMsg);
        }

        if (LOG_ENTRY)
        {
//            WriteTimestampedLogEntry(sMsg);
            PrintString(sMsg);
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: DB_GetObjectByTag
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 19, 2005
//::////////////////////////////////////////////////////////////////////////////
object DB_GetObjectByTag(string sTag, int nNth = 0)
{
    // Collect the object.
    object oObj = GetObjectByTag(sTag, nNth);

    // If in debug mode validate the object.
    if (DEBUG_MODE)
    {
        if (!GetIsObjectValid(oObj))
        {
            object oPC = GetFirstPC();
            string sDebug = "OBJECT_INVALID::DB_GetObjectByTag(" + sTag +
                ", " + IntToString(nNth) + ")";

            DebugMessage(sDebug);
        }
    }

    return oObj;
}

//::////////////////////////////////////////////////////////////////////////////
//:: DB_GetNearestObjectByTag
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:aug 19, 2005
//::////////////////////////////////////////////////////////////////////////////
object DB_GetNearestObjectByTag(string sTag, object oTarget = OBJECT_SELF, int nNth = 1)
{
    // Collect the object.
    object oObj = GetNearestObjectByTag(sTag, oTarget, nNth);

    // If in debug mode check the object's validity.
    if (DEBUG_MODE)
    {
        // If the object retreived by the call to GetNearestObject is invalid.
        if (!GetIsObjectValid(oObj))
        {
            object oPC = GetFirstPC(); // Send debug info to the first player.
            string sDebug = "OBJECT_INVALID::DB_GetNearestObjectByTag("
                + sTag + ", " + GetTag(oTarget) + ", "
                + IntToString(nNth) + ")";

            DebugMessage(sDebug); // Log debug information.
        }
    }

    return oObj;
}


//::////////////////////////////////////////////////////////////////////////////
//:: DB_GetWaypointByTag
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Aug 22, 2005
//::////////////////////////////////////////////////////////////////////////////
object DB_GetWaypointByTag(string sWaypointTag)
{
    object oWP = GetWaypointByTag(sWaypointTag);

    if (DEBUG_MODE)
    {
        if (!GetIsObjectValid(oWP))
        {
            object oPC = GetFirstPC();
            string sDebug = "OBJECT_INVALID::DB_GetWaypointByTag("
                + sWaypointTag + ")";

            DebugMessage(sDebug);
        }
    }

    return oWP;
}

//::////////////////////////////////////////////////////////////////////////////
//:: DB_CreateObject
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 19, 2005
//::////////////////////////////////////////////////////////////////////////////
object DB_CreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "")
{
    object oObj = CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation, sNewTag);

    if (DEBUG_MODE)
    {
        if (!GetIsObjectValid(oObj))
        {
            object oPC = GetFirstPC();
            string sDebug = "INVALID_OBJECT::DB_CreateObject";

            DebugMessage(sDebug);

            // Determine the object type used in the attemped creation.
            string sType;

            switch (nObjectType)
            {
                case OBJECT_TYPE_ITEM:
                {
                    sType = "OBECT_TYPE_ITEM";
                }
                case OBJECT_TYPE_PLACEABLE:
                {
                    sType = "OBJECT_TYPE_PLACEABLE";
                }
                case OBJECT_TYPE_STORE:
                {
                    sType = "OBJECT_TYPE_STORE";
                }
                case OBJECT_TYPE_WAYPOINT:
                {
                    sType = "OBJECT_TYPE_WAYPOINT";
                }
                default:
                {
                    sType = "OBJECT_TYPE_UNKOWN";
                }
            }

            // Display object type.
            sDebug = "nObjectType::" + sType + "::" + IntToString(nObjectType);

            DebugMessage(sDebug);

            // Display ResRef used.
            sDebug = "sTemplate::" + sTemplate;

            DebugMessage(sDebug);

            // Display the vector of the objects location followed by area.
            sDebug = "lLocation::" + LocationToString(lLocation);

            DebugMessage(sDebug);

            // Display Use AppearAnimation Boolean.
            if (bUseAppearAnimation)
            {
                sDebug = "bUseAppearAnimation::TRUE";
            }
            else
            {
                sDebug = "bUseAppearAnimation::FALSE";
            }

            DebugMessage(sDebug);

            // Display new tag for reference.
            sDebug = "sNewTag::" + sNewTag;

            DebugMessage(sDebug);
        }
    }

    return oObj;
}

