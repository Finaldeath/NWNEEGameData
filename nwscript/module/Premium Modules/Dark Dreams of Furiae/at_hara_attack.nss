#include "ddf_journal"
#include "nw_i0_generic"

void main()
{
    ExecuteScript("at_attack", OBJECT_SELF);

    object oPC = GetPCSpeaker();


    SetLocalInt(GetModule(), "ddf_confront_harasi", TRUE);
    UpdateJournal(oPC);

    object oFriend = GetFirstObjectInArea(GetArea(OBJECT_SELF));

    while (GetIsObjectValid(oFriend))
    {
        // If the object is a creature that is a member of my faction
        if (GetFactionEqual(oFriend) && (GetObjectType(oFriend) == OBJECT_TYPE_CREATURE))
        {
            // ...and it can see the PC
            if (GetObjectSeen(GetPCSpeaker(), oFriend))
            {
                // Tell him to start combat
                AssignCommand(oFriend, DetermineCombatRound());
            }
            else // Otherwise, if he can't see the PC
            {
                // Tell him to stop what he's doing
                AssignCommand(oFriend, ClearAllActions());

                // ...and come to my location
                AssignCommand(oFriend, ActionMoveToObject(oPC, TRUE, 2.0f));
                AssignCommand(oFriend, ActionAttack(oPC));
            }
        }

        oFriend = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }
}
