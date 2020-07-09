#include "inc_id_liltimmy"

void main()
{
    // hagatha was the third lieutenant
    SetLocalInt(GetModule(), "bThirdLieutenant", TRUE);

    // decide on the first inner circle
    int nInnerCircle = Random(3) + 1;

    // set the first inner circle
    lt_SetFirstBoss(nInnerCircle);
    SetDungeonParameters(2, nInnerCircle);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
