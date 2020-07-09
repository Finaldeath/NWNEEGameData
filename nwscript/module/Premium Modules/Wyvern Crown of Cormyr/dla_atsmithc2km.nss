//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen
Step 2  Record the weapon chosen

*/

//Uncomment the weapon chosen
void main()
{
    object oPC = GetPCSpeaker();
//    string sItem = "rbastardsword"; //script c2bs
    string sItem = "rkama"; //script c2km
//    string sItem = "rkukri"; //script c2ku
//    string sItem = "rsickle"; //script c2si
//    string sItem = "rtwoblade"; //script c2tb
//    string sItem = "rheavyflail"; //script c2hf
//    string sItem = "rlightflail"; //script c2lf
//    string sItem = "rlighthammer"; //script c2lh
//    string sItem = "rmace"; //script c2ma
//    string sItem = "rmorningstar"; //script c2mo
//    string sItem = "rquarterstaff"; //script c2qu
//    string sItem = "rwarhammer"; //script c2wh
//    string sItem = "rdagger"; //script c2da
//    string sItem = "rgreatsword"; //script c2gs
//    string sItem = "rlongsword"; //script c2ls
//    string sItem = "rshortsword"; //script c2ss
//    string sItem = "rscimitar"; //script c2sc
//    string sItem = "rhandaxe"; //script c2hx
//    string sItem = "rbattleaxe"; //script c2bx
//    string sItem = "rgreataxe"; //script c2gx
//    string sItem = "rhalberd"; //script c2ha
//    string sItem = "rspear"; //script c2sp
    SetLocalString(OBJECT_SELF,"sItem",sItem);
}
