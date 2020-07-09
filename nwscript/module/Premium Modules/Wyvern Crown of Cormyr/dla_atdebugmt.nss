////////////////////////////////////////////////////////////////////////////////
// :: Created By: Deva B. Winblood
// :: Created On: 7/30/2006
// :: This script will turn on or off horse mount/dismount animations based on
// :: selections made in debug wand dialog
////////////////////////////////////////////////////////////////////////////////

void main()
{
    int nParm=GetLocalInt(GetPCSpeaker(),"nParm");
    DeleteLocalInt(GetPCSpeaker(),"nParm");
    if (nParm==2) DeleteLocalInt(GetModule(),"bDLAHorseNoAnimate");
    else { SetLocalInt(GetModule(),"bDLAHorseNoAnimate",1); }
}
