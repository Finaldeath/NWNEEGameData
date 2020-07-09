//gives the PC a bottle of Elfsong Cider
//Author: Damian Brown (Luspr)
//Date:02-Aug-2005
void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("db_elfsongcider", oPC, 1);
}
