#include "inc_id_liltimmy"

void main()
{
    // harat was the second inner circle
    SetLocalInt(GetModule(), "bSecondBoss", TRUE);

    // get the first inner circle
    int nInnerCircle = lt_GetFirstBoss();

    if (nInnerCircle == 2) // it was g'zhorb
    {
        nInnerCircle = 3; // next is masterius
    } else // it was masterius
    {
        nInnerCircle = 2; // next is g'zhorb
    }

    // set the third inner circle
    lt_SetThirdBoss(nInnerCircle);
    SetDungeonParameters(2, nInnerCircle);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
