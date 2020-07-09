/////////////////////////////////////////////
//This will create the mariners uniform on the player
//which is needed to enter the mariners alliance
//
//Author: Phil Mitchell (Baron of Gateford)
////////////////////////////////////////////
void main()
{
 int iGender = GetGender(GetPCSpeaker());
 CreateItemOnObject("pm_marinerrobe", GetPCSpeaker(), 1);

}
