//::///////////////////////////////////////////////
//:: FileName con_ac_vladport2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb. 25, 2006
//:://////////////////////////////////////////////
void main()
{
//Set variables
object oPC = GetPCSpeaker();
object oF = GetObjectByTag("ac_fakeportrait");
SetLocalInt(GetPCSpeaker(), "ac_exchangedpainting", 1);

//Exchange paintings
CreateItemOnObject("ac_portrait_grts",oPC);
DestroyObject(oF);
FloatingTextStringOnCreature("You have successfully switched the portraits.",oPC);
}
