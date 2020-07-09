#include "dla_i0_joust"

void main()
{
    SetCustomToken(9901, "FALSE");
    SetCustomToken(9902, "FALSE");
    SetCustomToken(9903, "FALSE");
    SetCustomToken(9904, "FALSE");
    SetCustomToken(9905, "FALSE");
    SetCustomToken(9906, "FALSE");
    SetCustomToken(9907, "FALSE");
    SetCustomToken(9908, "FALSE");
    SetCustomToken(9911, "FALSE");
    SetCustomToken(9912, "FALSE");
    SetCustomToken(9913, "FALSE");
    SetCustomToken(9914, "FALSE");
    SetCustomToken(9915, "FALSE");
    SetCustomToken(9916, "FALSE");
    SetCustomToken(9917, "FALSE");
    SetCustomToken(9918, "FALSE");

    object oPC = GetPCSpeaker();
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_STARTED))
        SetCustomToken(9901, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_1))
        SetCustomToken(9902, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_2))
        SetCustomToken(9903, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_3))
        SetCustomToken(9904, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_4))
        SetCustomToken(9905, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_CHAMP))
        SetCustomToken(9906, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_LOST))
        SetCustomToken(9907, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T1_DONE))
        SetCustomToken(9908, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED))
        SetCustomToken(9911, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_1))
        SetCustomToken(9912, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_2))
        SetCustomToken(9913, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_3))
        SetCustomToken(9914, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_4))
        SetCustomToken(9915, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_CHAMP))
        SetCustomToken(9916, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_LOST))
        SetCustomToken(9917, "TRUE");
    if (DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_DONE))
        SetCustomToken(9918, "TRUE");
}
