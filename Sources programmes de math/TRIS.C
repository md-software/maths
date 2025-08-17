#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

float get_time(clock_t start, clock_t end)
{

return ((end - start) / CLK_TCK);
}

void tri_bulles (int tab[], int N)
{
	int i,j,temp;

for (i = N; i >= 1;i--)
	{
	for (j = 2; j <= i; j++)
		{
		if (tab[j-1] > tab[j])
			{
			temp = tab[j];
			tab[j] = tab[j-1];
			tab[j-1] = temp;
			}
		}
	}

return;
}

void tri_insertion (int tab[], int N)
{
	int i,j,cle;

tab[0] = -1;

for (i = 2; i <= N;i++)
	{
	j = i;
	cle = tab[i];
	while (tab[j-1] > cle)
		{
		tab[j] = tab[j-1];
		j--;
		}
	tab[j] = cle;
	}

return;
}

void tri_shellsort (int tab[], int N)
{
	int i,j,k,cle;

for (k = N+1; k > 1;)
	{
	if (k < 5)
		k = 1;
	else
		k = (5*k-1)/11;	
	for (i = k+1; i <= N; i+=k)
		{
		j = i;
		cle = tab[i];

		while (j > k && tab[j-k] > cle)
			{
			tab[j] = tab[j-k];
			j -= k;
			}
		tab[j] = cle;
		}
	}

return;
}

void tri_quicksort(int tab[], int premier, int dernier)
{
	int i, m, temp, cle;

if (premier < dernier)
	{
	cle = tab[premier];
	m = premier;

	for (i = premier+1;i <= dernier;i++)
		{
		if(tab[i] < cle)
			{
                        m++;
			temp = tab[i];
			tab[i] = tab[m];
			tab[m] = temp;
			}

		}

	temp = tab[premier];
	tab[premier] = tab[m];
	tab[m] = temp;

	tri_quicksort(tab,premier,m-1);
	tri_quicksort(tab,m+1,dernier);
	}

return;
}

void verifie_tas (int tab[], int N, int k)
{
	int j,cle;

cle = tab[k];

while (k <= N/2)
	{
	j = k+k;
	if (j < N && tab[j] < tab[j+1])
		j++;

	if (cle >= tab[j])
		break;

	tab[k] = tab[j];
	k = j;
	}

tab[k] = cle;

return;
}

void tri_heapsort (int tab[], int N)
{
	int k,temp;

for (k = N/2; k >= 1; k--)
	verifie_tas(tab,N,k);

while (N > 1)
	{
	temp = tab[1];
	tab[1] = tab[N];
	tab[N] = temp;
	N--;
	verifie_tas(tab,N,1);
	}

return;
}

void verifie_tri(int tab[], int N)
{
	int i;

for (i = 2; i <= N; i++)
	if (tab[i-1] > tab[i])
		{
		printf("Verifie_tri : Mauvais\n");
		return;
		}

printf("Verifie_tri : OK\n");
return;
}
 
#define N 1000

int main()
{
	int tab[N+1];
	int i;
	char s[16];
	clock_t start,end;

printf("Return pour commencer ");
gets(s);

randomize();
for (i = 1; i <= N; i++)
	tab[i] = random(N) + 1;

printf("Début tri_bulles\n");
start = clock();
tri_bulles(tab,N);
end = clock();
printf("Fin   tri_bulles : %f\n",get_time(start,end));
verifie_tri(tab,N);

randomize();
for (i = 1; i <= N; i++)
	tab[i] = random(N) + 1;

printf("Début tri_insertion\n");
start = clock();
tri_insertion(tab,N);
end = clock();
printf("Fin   tri_insertion : %f\n",get_time(start,end));
verifie_tri(tab,N);

randomize();
for (i = 1; i <= N; i++)
	tab[i] = random(N) + 1;

printf("Début tri_shellsort\n");
start = clock();
tri_shellsort(tab,N);
end = clock();
printf("Fin   tri_shellsort : %f\n",get_time(start,end));
verifie_tri(tab,N);

randomize();
for (i = 1; i <= N; i++)
	tab[i] = random(N) + 1;

printf("Début tri_quicksort\n");
start = clock();
tri_quicksort(tab,1,N);
end = clock();
printf("Fin   tri_quicksort : %f\n",get_time(start,end));
verifie_tri(tab,N);

randomize();
for (i = 1; i <= N; i++)
	tab[i] = random(N) + 1;

printf("Début tri_heapsort\n");
start = clock();
tri_heapsort(tab,N);
end = clock();
printf("Fin   tri_heapsort : %f\n",get_time(start,end));
verifie_tri(tab,N);

return 0;
}