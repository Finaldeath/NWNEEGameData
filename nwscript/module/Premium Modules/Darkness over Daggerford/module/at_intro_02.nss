// player levels up according to his/her package

#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    int nLevelsToGain = 8 - GetHitDice(oPC);
    if (nLevelsToGain >= 1)
    {
        int i;
        for (i=1; i<=nLevelsToGain; i++)
        {
            LevelUpHenchman(oPC, CLASS_TYPE_INVALID, TRUE);
        }
    }
    CutsceneNextShot();
}
