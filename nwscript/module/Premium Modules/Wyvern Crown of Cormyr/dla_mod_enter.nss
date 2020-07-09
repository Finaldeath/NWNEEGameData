//::///////////////////////////////////////////////
//:: Module OnEnter Event
//:: dla_horse_onent
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    Resets any needed aspects of the system for PCs which re-enter the module
    mounted. Currently does the following:

    -Resets Increased movement speed.
    -Resets using ranged weapon while mounted penaulty

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 1, 2005
//:://////////////////////////////////////////////
//:: Updated By: B W-Husey
//:: Updated On: May 15th, 2006
//:://////////////////////////////////////////////
//:: Updated By: Bill Harper
//:: Updated On: October 30, 2019
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_i0_feats"

void main()
{
    //declare variables
    object oPC = GetEnteringObject();

    if (!GetHasFeat(IP_CONST_FEAT_DLA_HORSE_MENU))
       DLA_GiveFeat(oPC, IP_CONST_FEAT_DLA_HORSE_MENU);

    //some settings not persistent, need to reset on PCs entering from
    //log-out/server reset.
    //Gale 8 Jun 2005: Using new encapsulating function
    DLA_RefreshMovementSpeed(oPC);

    //Gale 3 Dec 2005
    //Apply penaulty if using ranged weapon and is mounted.
    //Take in account mounted archery feat penaulty reduction
    AssignCommand(oPC, DLA_RefreshMountedArcheryPenalty());

    //Gale 10 Dec 2005
    //Just in case, setting the PC as not being on a "no mount" area.
    //could be wrongly seted if the server crashed
    DeleteLocalInt(oPC, "DLA_CANT_MOUNT");

    //Gives the experience to jump directly to level 2 to receive horses feat
    //Takamura 08/18/2005
//    GiveXPToCreature(oPC, 1000);

// Adding in a little code to cure the infamouse Horse Hat bug
    if (GetCreatureTailType(oPC) == 14 && GetLocalInt(oPC,"CheckHorseHat") != 1) // This is Null Tail in the 1.69+ tailmodel.2DA
    {
        SetLocalInt(oPC,"CheckHorseHat",1);
        SetCreatureTailType(68,oPC);  // This is Null Tail in the DLA tailmodel.2DA
    }

}
