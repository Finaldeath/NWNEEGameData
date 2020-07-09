/* Use a placeable wall door. This allows for locks and traps to be
 * placed on the door and plays an animation of the user opening
 * the door.
 *
 * Works for both standard and secret doors. For standard, the tag
 * of the waypoint destination must be set to LOC_<tag of door>.
 * For secret, the waypoint should be set to LOC_<tag of detect trigger>.
 *
 * This goes in the OnUsed event handler of the actual
 * placeable door object.
 */

// Modified B W-Husey to properly transition henchmen

#include "x0_i0_secret"
#include "cu_functions"

//function changed to use GroupTransition as TransportToWaypoint didn't work
void UseSecretTransport2(object oPC, object oSecretItem=OBJECT_SELF)
{
    // Get the tag of the detection trigger. If it doesn't exist,
    // use the item itself. (This is mainly for convenience so we
    // can reuse this script for regular trap doors, etc.)
    object oTrigger = GetLocalObject(oSecretItem, sDetectTriggerVarname);
    string sTag;
    if (GetIsObjectValid(oTrigger)) {
        sTag = GetTag(oTrigger);
    } else {
        sTag = GetTag(oSecretItem);
    }

    // Get the destination waypoint
    string sDestTag = sDestinationPrefix + sTag;
    object oWaypoint = GetNearestObjectByTag(sDestTag);

    // Manually look for fallback since GetNearestObjectByTag
    // doesn't find anything outside the area.
    if ( ! GetIsObjectValid(oWaypoint) )
        oWaypoint = GetObjectByTag(sDestTag);

    // Transport away
    if (GetIsObjectValid(oWaypoint)) {
        GroupTransition(oPC, oWaypoint);
    }
}
void main()
{
    object oUser = GetLastUsedBy();

    // Allow for traps and locks
    if (GetIsTrapped(OBJECT_SELF)) {return;}

    if (GetLocked(OBJECT_SELF)) {
        // See if we have the key and unlock if so
        string sKey = GetTrapKeyTag(OBJECT_SELF);
        object oKey = GetItemPossessedBy(oUser, sKey);
        if (sKey != "" && GetIsObjectValid(oKey)) {
            SendMessageToPC(oUser, GetStringByStrRef(7945));
            SetLocked(OBJECT_SELF, FALSE);
        } else {
            // Print '*locked*' message and play sound
            DelayCommand(0.1, PlaySound("as_dr_locked2"));
            FloatingTextStringOnCreature("*"
                                         + GetStringByStrRef(8307)
                                         + "*",
                                         oUser);
            SendMessageToPC(oUser, GetStringByStrRef(8296));
            return;
        }
    }

    // Handle opening/closing
/*    if (!GetIsSecretItemOpen(OBJECT_SELF)) {
        // play animation of user opening it
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
        DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        SetIsSecretItemOpen(OBJECT_SELF, TRUE);
    } else
    {  */
        // it's open -- go through and then close
        UseSecretTransport2(GetLastUsedBy());
//        ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
//        SetIsSecretItemOpen(OBJECT_SELF, FALSE);
//    }
}
