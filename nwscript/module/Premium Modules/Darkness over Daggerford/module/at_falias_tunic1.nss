/////////////////////////////////////////////
//This will create the tunic/dress on the player
//which is needed to enter the Chateu Elite
//
//Author: Phil Mitchell (Baron of Gateford)
//Date: 30-Jun-2005
////////////////////////////////////////////
void main()
{
 int iGender = GetGender(GetPCSpeaker());
 if (iGender == GENDER_MALE)
     CreateItemOnObject("pm_custom_tunic", GetPCSpeaker(), 1);
 else
     CreateItemOnObject("pm_custom_dress", GetPCSpeaker(), 1);
}
