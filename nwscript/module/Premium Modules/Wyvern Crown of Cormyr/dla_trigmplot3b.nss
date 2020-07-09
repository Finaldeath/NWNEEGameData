// B W-Husey
// October 2005
// Fire the arrest cutscene once Edgar has been rescued (nMainPlot =3), with subsequent dialogue.

#include "x2_inc_switches"
#include "cu_functions"
#include "dla_i0_horse"
#include "dla_i0_horseai"

//allows delay of horse tying script
void DoRemoval(object oPC,object oHitchingPost)
{
    DLA_RemoveAllHenchmenHorses(oPC,oHitchingPost);
}

void main()
{
object oPC = GetEnteringObject();
if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nMainPlot")==3)
    {
    //Debug line ***************
//    SendMessageToPC(oPC,"I am firing up the arrest cutscene");
    //Dismount before cutscene
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);
    object oHitchingPost = GetNearestObjectByTag(DLA_TAG_HITCHING_POST);
    DelayCommand(0.5,AssignCommand(oPC,ClearAllActions()));
    FadeToBlack(oPC);
    if (DLA_GetIsMounted(oPC))     DelayCommand(1.0, DLA_Dismount (oPC,FALSE));
    if (DLA_GetIsMounted(oHench1))DelayCommand(1.0, DLA_Dismount (oHench1,FALSE));
    if (DLA_GetIsMounted(oHench2))DelayCommand(1.0, DLA_Dismount (oHench2,FALSE));
    DelayCommand(1.1,DoRemoval(oPC,oHitchingPost));
    // Fire cutscene
    DelayCommand(5.0,FadeFromBlack(oPC));
    DelayCommand(4.0,ExecuteScript("dla_cutarrest",oPC));   // Do the cutscene in a seperate script so you can test without it.
    DestroyObject(OBJECT_SELF,6.0);
    }

}


