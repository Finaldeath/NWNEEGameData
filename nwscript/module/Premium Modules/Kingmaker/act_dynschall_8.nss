//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Give Random amount of gold to PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: July 21, 2003
//:://////////////////////////////////////////////
void main()
{
    int nGP = (Random (100));
    GiveGoldToCreature(GetFirstPC(),nGP);
    SetLocalInt(GetFirstPC(),"os_askedforgold",1);
}
