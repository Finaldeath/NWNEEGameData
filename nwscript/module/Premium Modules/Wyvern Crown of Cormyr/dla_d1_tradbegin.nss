//::///////////////////////////////////////////////
//:: dla_d1_tradbegin
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

This script runs at the beginning of the horse trader's conversation

It clears the horse variable at the beginning and prepares the conversation.

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 7, 2005
//:://////////////////////////////////////////////

//Gale 23 April 2006:
//Added Reseting of iHorseBarding localvar

void main()
{
    object oPC = GetPCSpeaker();
    DeleteLocalInt(oPC, "iHorseVar");
    DeleteLocalInt(oPC, "iHorseTexture");
    DeleteLocalInt(oPC, "iHorseBarding");
}
