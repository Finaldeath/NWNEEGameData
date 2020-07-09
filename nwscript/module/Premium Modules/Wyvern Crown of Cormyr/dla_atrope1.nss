// June 2003
// B W-Husey
// Use of rope and movement to waypoint in another area. This one takes the rope away.

// Gale 18 June 2006: Remade to avoid having horses transitioned with PC
#include "dla_i0_horse"
#include "cu_functions"

void MoveToFinalLocation(object oPC);
void CheckIfSomeoneStillMounted(object oPC);

void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    object oPC = GetPCSpeaker();
    oItemToTake = GetItemPossessedBy(oPC, "Rope");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    SetCutsceneMode(oPC);

    DLA_RemovePartyHorsesAndLeaveOnPlace(oPC);
    CheckIfSomeoneStillMounted(oPC);
}

void CheckIfSomeoneStillMounted(object oPC)
{
    if (DLA_GetIsMounted(oPC))
    {
        DelayCommand(0.4, CheckIfSomeoneStillMounted(oPC));
        return;
    }
    int i;
    object oHench;
    while (GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, ++i)))
        if (DLA_GetIsMounted(oHench))
        {
            DelayCommand(0.4, CheckIfSomeoneStillMounted(oPC));
            return;
        }
    DelayCommand(3.0, MoveToFinalLocation(oPC));
}


void MoveToFinalLocation(object oPC)
{
    GroupTransition(oPC,GetNearestObjectByTag("TP_Rope"));
    AllParty("nLWRope1",oPC,1);//set variable so can get back across
    SetCutsceneMode(oPC, FALSE);
}
