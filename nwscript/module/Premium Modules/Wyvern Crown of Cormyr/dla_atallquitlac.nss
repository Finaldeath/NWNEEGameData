// November 2005
// B W-Husey
//Henchman is annoyed and quits the party
#include "x0_i0_henchman"
#include "dla_i0_horse"

void main()
{
    //henchman to remove
    object oHench = GetObjectByTag("Lacinda");
    string sTag = GetTag(oHench);
    object oPC = GetPCSpeaker();
    //set annoyed
    SetLocalInt(oHench,"Annoyed",1);
    // remove from party
    QuitHenchman(oPC,oHench);
    DLA_RemoveHenchman(oPC, oHench);
    //send them packing
        object oHome = GetObjectByTag("Hench_"+sTag);
        AssignCommand(oHench,ActionMoveAwayFromObject(oPC,TRUE));
        DelayCommand(4.0,AssignCommand(oHench,JumpToObject(oHome)));
}
