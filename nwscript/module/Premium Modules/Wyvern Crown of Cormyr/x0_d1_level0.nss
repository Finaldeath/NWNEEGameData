//::///////////////////////////////////////////////
//:: x0_d1_level0
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets the levelup mode to standard
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

//Gale 19th May 2006:
//Instead of settting the var to 0, deleting it
void main()
{
    DeleteLocalInt(OBJECT_SELF, "X0_L_LEVELRULES");
}
