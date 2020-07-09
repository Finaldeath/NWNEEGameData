//Destroy the dice on the table

void main()
{
    DestroyObject(GetNearestObjectByTag("Dice1"));
    DestroyObject(GetNearestObjectByTag("Dice2"));
    DestroyObject(GetNearestObjectByTag("Dice3"));
}
