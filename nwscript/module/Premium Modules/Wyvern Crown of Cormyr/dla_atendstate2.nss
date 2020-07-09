//B W-Husey
// March 2006
// Display this dialogue based on the final choices of the player
/*
Variable: nFinishState	integer stored on PC and party
	1 Kept the crown - mean to give to Caladnei
	2 Kept the crown for self - killed WL
	3 Gave crown to WL
	4 Kept the crown for self - kept WL
*/

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nState = GetLocalInt(oPC,"nFinishState");
    if (nState==2) return TRUE;
    return FALSE;
}
