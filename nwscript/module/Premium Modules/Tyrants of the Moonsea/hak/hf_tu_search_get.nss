// use this script in conversation to reward the player with the secret item
// from a secret placeable, by convention, the object's plot level is set to 9
// when successful

#include "hf_in_plot"
#include "hf_in_alignment"

// plays the given animation and returns the animation duration
float PlayGetAnimation(object oPC, string sAnimName)
{
    string sAnim = GetStringLowerCase(sAnimName);
    if (sAnim == "low")
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0));
        return 1.0;
    }
    if (sAnim == "mid")
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
        return 1.0;
    }
    if (sAnim == "read")
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        return 1.5;
    }
    if (sAnim == "drink")
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        return 1.5;
    }
    return 0.0;
}

void main()
{
    object oPC = GetPCSpeaker();
    float fDur = 0.0;

    string sItem = GetLocalString(OBJECT_SELF, "HF_SECRET_ITEM");
    object oItem = CreateItemOnObject(sItem, oPC);
    if (GetIsObjectValid(oItem))
    {
        string sAnim = GetLocalString(OBJECT_SELF, "HF_SECRET_ANIM");
        if (sAnim != "")
        {
            fDur = PlayGetAnimation(oPC, sAnim);
        }

        string sSound = GetLocalString(OBJECT_SELF, "HF_SECRET_SOUND");
        if (sSound != "")
        {
            DelayCommand(fDur, AssignCommand(oPC, PlaySound(sSound)));
        }

        int nGood = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_GOOD");
        if (nGood > 0)
        {
            AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, nGood);
        }
        int nEvil = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_EVIL");
        if (nEvil > 0)
        {
            AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, nEvil);
        }
        int nLawful = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_LAWFUL");
        if (nLawful > 0)
        {
             AdjustPlayerAlignment(oPC, ALIGNMENT_LAWFUL, nLawful);
       }
        int nChaotic = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_CHAOTIC");
        if (nChaotic > 0)
        {
            AdjustPlayerAlignment(oPC, ALIGNMENT_CHAOTIC, nChaotic);
        }

        PlotLevelSet(GetTag(OBJECT_SELF), 9);
    }
}
