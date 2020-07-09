#include "hf_in_cutscene"

void main()
{
    CutsceneNextShot();
    //flag player has met Teygan
    SetLocalInt(GetModule(),"teygan_start", 2);
}
