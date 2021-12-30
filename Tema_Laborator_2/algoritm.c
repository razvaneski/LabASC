/*

Algoritmul functioneaza astfel:

Se citesc N si M din cerinta, urmand a se citi 3 * N elemente. Elementele se depoziteaza
in perm[i], cu i intre 1 si 3 * N.

In aceasta sursa am considerat inca un vector init, in care stocam sirul initial. Astfel,
putem vedea daca elementul curent este un element fixat in vector, testand daca exista
valoare nenula in init[i]. In varianta Assembly, am modificat aceasta testare, pentru a
eficientiza memoria, folosind doar vectorul perm si stocand elementele fixate inmultite cu
-1. Astfel, daca in perm[i] vom avea o valoare negativa, vom sti ca pe pozitia i se afla
un element fixat.

Functia back functioneaza astfel:

Avem un unic parametru curr in care stocam pozitia actuala la care ne aflam. Astfel, daca 
curr este mai mare decat 3 * N, inseamna ca am ajuns la o permutare minim posibila, si ne
putem opri din executie. Altfel, exista doua cazuri:

a) Cazul in care in init[curr] exista valoare nenula/perm[curr] este negativ:

Inseamna ca pe pozitia curenta avem un element fixat. Nu este nevoie sa facem modificari,
asa ca vom trece mai departe apeland back(curr + 1)

b) Cazul in care in init[curr] nu exista valoare/perm[curr] este >= 0:

Inseamna ca pe pozitia actuala trebuie sa modificam valoarea. Plecam de la valoarea existenta
in perm[curr], adunam 1 si incercam sa gasim cea mai mica valoare pe care o putem stoca in
perm[curr] (adica folosita deja de cel mult 2 ori si unica pe intervalul [curr - m, curr + m]).
Daca gasim o astfel de valoare, o punem in perm, crestem frecventa si trecem mai departe prin
back(curr + 1).

Daca nu gasim o astfel de valoare, inseamna ca trebuie sa ne intoarcem. Mergem inapoi cu curr
pana cand gasim prima pozitie cu un element ne-fixat (valoare nula in init/valoare pozitiva
in perm), apoi apelam back(curr). In varianta Assembly am adaugat si cazul in care curr ajunge
dupa aceasta cautare la o valoare mai mica decat 1: asta inseamna ca am dat inapoi pana la
inceputul vectorului si totusi nu am gasit niciun element ne-fixat, ceea ce inseamna ca este
clar ca nu exista nicio permutare corecta, deci putem afisa -1 si incheia rularea.

Apeland back(curr) dupa ce ne intoarcem la o pozitie in care deja am pus o valoare, observam
ca i pleaca de la perm[curr] + 1 in cautarea elementului potrivit. Astfel, evitam cazul in
care bagam de mai multe ori aceeasi valoare in perm, rezultand o bucla infinita

Sursa .asm: 152_Dumitriu_RazvanCristian.asm . Din pacate, algoritmul este unul iterativ,
insa echivalent cu cel din sursa C.

*/
 
#include <stdio.h>
#define MAXN 30

int init[105];
int perm[105];
int f[35];
int n, m;

void back(int curr) {
	int i, j, elem, ok;

	if(curr > 3 * n) {
		return;
	}
	else {
		if(init[curr] != 0) {
			back(curr + 1);
		}
		else {
		    i = perm[curr] + 1;
		    f[perm[curr]]--;
		    perm[curr] = 0;
			elem = 0;
			while(i <= n && elem == 0) {
				if(f[i] < 3) {
					ok = 1;
					for(j = 1; j <= m && curr - j > 0; j++)
						if(perm[curr - j] == i)
							ok = 0;
					for(j = 1; j <= m && curr + j <= 3 * n; j++)
						if(perm[curr + j] == i)
							ok = 0;
					if(ok)
						elem = i;
				}
				i++;
			}
			if(elem != 0) {
				f[elem]++;
				perm[curr] = elem;
				back(curr + 1);
			}
			else {
				f[perm[curr]]--;
				perm[curr] = 0;
				curr--;
				while(curr > 0 && init[curr] != 0)
					curr--;
				back(curr);
			}
		}
	}
}

int main() {
	int i, j, ok;

	scanf("%d%d", &n, &m);
	for(i = 1; i <= 3 * n; i++) {
		scanf("%d", &init[i]);
		f[init[i]]++;
		perm[i] = init[i];
	}
	back(1);

	ok = 1;
	for(i = m + 1; i <= 3 * n - m; i++) {
		for(j = 1; j <= m; j++)
			if(perm[i] == perm[i - j] || perm[i] == perm[i + j])
				ok = 0;
	}

	if(ok == 1) {
		for(i = 1; i <= 3 * n; i++)
			printf("%d ", perm[i]);
		printf("\n");
	}
	else
		printf("-1\n");
	return 0;
}