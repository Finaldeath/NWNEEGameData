//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: aen_tm_fndclean
// DATE: September 8, 2005
// AUTH: Luke Scull/Rich Barker
// NOTE: Removes fiends in Voonlar so that they don't
// follow PC into temple and break cutscene.

// Edited again: ALL creatures removed, just in case
// the player has struck a Zhent or guard with a stray
// fireball. We don't want any faction problems once
// player has left temple.

// Amended to remove corpse inventory items to prevent
// selectable invisible objects from appearing on 'tab'
//
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void DestroyCorpse(object oCreature, float fDelay);

void main()
{
    object oPC = GetEnteringObject();

    // Make sure player is entering object and trigger hasn't fired before
    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "fired") == 0)
    {
        object oArea = GetArea(GetWaypointByTag("POST_GrimswoldStocks"));
        // Cycle through all the creature objects in Voonlar and destroy
        object oTarget = GetFirstObjectInArea(oArea);

        while(GetIsObjectValid(oTarget))
        {
            if(GetIsPC(oTarget))
            {
                oTarget = GetNextObjectInArea(oArea);
                continue;
            }

            //If creature is dead, empty inventory to avoid selectable highlight
            //being left, and then destroy.
            if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                if(GetIsDead(oTarget))
                {
                    AssignCommand(oTarget, SetIsDestroyable(TRUE, FALSE, FALSE));
                    DestroyCorpse(oTarget, 1.0);
                }
                //Destroy only if not cow, dog, or Voonlar Guard
                else
                {
                    if(GetTag(oTarget) == "NW_COW" ||
                       GetTag(oTarget) == "NW_DOG" ||
                       GetStringLeft(GetTag(oTarget), 12) == "VoonlarGuard")
                    {
                        AssignCommand(oTarget, ClearAllActions(TRUE));
                        ClearPersonalReputation(oPC, oTarget);
                    }
                    else
                    {
                        AssignCommand(oTarget, SetIsDestroyable(TRUE, FALSE, FALSE));
                        DestroyObject(oTarget, 0.0);
                    }
                }
            }
            oTarget = GetNextObjectInArea(oArea);
        }

        //Reset Commoner and Merchant faction reputations
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 50, oPC);
        // Set int so trigger won't fire again
        SetLocalInt(OBJECT_SELF, "fired", 1);
    }
}

void DestroyCorpse(object oCreature, float fDelay = 0.0)
{
    int nSlot;

    object oBag;
    object oItem;

    //Empty target creature inventory or Remains will be left
    for (nSlot=0; nSlot<NUM_INVENTORY_SLOTS; nSlot++)
    {
        oItem = GetItemInSlot(nSlot, oCreature);
        DestroyObject(oItem);
    }

    //Empty and remove creature's body bag which contains its inventory items
    oBag = GetNearestObjectByTag("BodyBag", oCreature);
    oItem = GetFirstItemInInventory(oBag);

    while(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oBag);
    }

    DestroyObject(oCreature, fDelay);
    DestroyObject(oBag, fDelay);
}
