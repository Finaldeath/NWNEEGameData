//::///////////////////////////////////////////////
//:: FileName dla_atcalad2horn
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: 11/02/2006 11:53:24
//:://////////////////////////////////////////////
void main()
{
    if (GetLocalInt(OBJECT_SELF,"nHorns")==0)
    {
    // Give the speaker the items
    CreateItemOnObject("assaulthorn", GetPCSpeaker(), 1);
    CreateItemOnObject("retreathorn", GetPCSpeaker(), 1);
    SetLocalInt(OBJECT_SELF,"nHorns",1);
    }

}
