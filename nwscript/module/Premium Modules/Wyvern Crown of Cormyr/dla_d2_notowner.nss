//:://////////////////////////////////////////////////
//:: dla_d2_notowner
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

   Checks if the horse wich the player is speaking to
   does have a master, and it's master is not the player

*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: December 03, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
   object oMaster = GetMaster(OBJECT_SELF);
   return GetIsObjectValid(oMaster) && oMaster != GetPCSpeaker();
}
