//::///////////////////////////////////////////////
//:: act_hen_interend
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The henchmen interjection has been made
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: Nov 2003
//:://////////////////////////////////////////////

void main()
{
    int nEnd = GetLocalInt(OBJECT_SELF,"OS_HENCH_CONV")+5;
    SetLocalInt(OBJECT_SELF,"OS_HENCH_CONV",nEnd);
}