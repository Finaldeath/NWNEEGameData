// Modified Secret Trapdoor script

#include "x0_i0_secret"
#include "cu_functions"


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
    if (!GetIsSecretItemOpen(OBJECT_SELF)) {
        // play animation of user opening it
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW));
        DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        SetIsSecretItemOpen(OBJECT_SELF, TRUE);
    }
}
