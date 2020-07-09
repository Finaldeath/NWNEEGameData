#include "inc_id_liltimmy"

void main()
{
    // g'zhorb was the second inner circle
    SetLocalInt(GetModule(), "bSecondBoss", TRUE);

    // get the first inner circle
    int nInnerCircle = lt_GetFirstBoss();

    if (nInnerCircle == 1) // it was harat
    {
        nInnerCircle = 3; // next is masterius
    } else // it was masterius
    {
        nInnerCircle = 1; // next is harat
    }

    // set the third inner circle
    lt_SetThirdBoss(nInnerCircle);
    SetDungeonParameters(2, nInnerCircle);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
