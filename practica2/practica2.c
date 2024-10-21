#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define N 512
float Mat[N][N];
float MatDD[N][N];
float V1[N];
float V2[N];
float V3[N];
float V4[N];

void InitData()
{
    int i, j;
    srand(334411);
    for (i = 0; i < N; i++)
        for (j = 0; j < N; j++)
        {
            Mat[i][j] = (((i * j) % 3) ? -1 : 1) * (100.0 * (rand() / (1.0 * RAND_MAX)));
            if ((abs(i - j) <= 3) && (i != j))
                MatDD[i][j] = (((i * j) % 3) ? -1 : 1) * (rand() / (1.0 * RAND_MAX));
            else if (i == j)
                MatDD[i][j] = (((i * j) % 3) ? -1 : 1) * (10000.0 * (rand() / (1.0 * RAND_MAX)));
            else
                MatDD[i][j] = 0.0;
        }
    for (i = 0; i < N; i++)
    {
        V1[i] = (i < N / 2) ? (((i * j) % 3) ? -1 : 1) * (100.0 * (rand() / (1.0 * RAND_MAX))) : 0.0;
        V2[i] = (i >= N / 2) ? (((i * j) % 3) ? -1 : 1) * (100.0 * (rand() / (1.0 * RAND_MAX))) : 0.0;
        V3[i] = (((i * j) % 5) ? -1 : 1) * (100.0 * (rand() / (1.0 * RAND_MAX)));
    }
}

// Problema 1
void PrintVect(float vect[], int from, int numel)
{
    int nombre = N;
    from -= 1;
    for (int i = 0; i < numel; i++)
    {
        if (from >= nombre || from < 0)
        {
            printf("Error, posicio no disponible.\n");
            break;
        }
        else
        {
            printf("%f ", vect[from]);
            from += 1;
        }
    }
    printf("\n");
}

int main()
{
    InitData();

    int from = 5;
    int numel = 4;

    printf("Elements de V1:\n");
    PrintVect(V1, from, numel);

    printf("Elements de V2:\n");
    PrintVect(V2, from, numel);

    printf("Elements de V3:\n");
    PrintVect(V3, from, numel);
}
